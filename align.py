#!/usr/bin/python

import os
import sys
import argparse
import tempfile
import subprocess

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("references", nargs="+", help="Reference FASTA file(s) used for alignment")
    parser.add_argument("reads", help="Reads FASTA or FASTQ file to be aligned")
    
    group = parser.add_mutually_exclusive_group()
    group.add_argument("-b", "--bam", action="store_true", default=False, help="Output a bam file")
    group.add_argument("-s", "--sam", action="store_true", default=False, help="Output a sam file")

    parser.add_argument("-o", "--out", help="Output file or destination (default is stdout)")
    parser.add_argument("--verbose", action="store_true", default=False, help="Output stderr from commands")
    args = parser.parse_args()
    
    if args.verbose:
        sys.stderr.write(str(args))
        STDERR = sys.stderr  
    else:
        STDERR = open(os.devnull, 'w')
    if args.out:
        STDOUT = open(args.out, 'w')
    else:
        STDOUT = sys.stdout

    # Index fasta file
    bwa_index_prefix = tempfile.NamedTemporaryFile().name
    subprocess.call(["bwa", "index", "-p", bwa_index_prefix] + args.references, stderr=STDERR)

    if args.bam:
        # Align reads > sorted bam > save
        temp_out = tempfile.NamedTemporaryFile()
        subprocess.call("bwa mem -v=0 {bwa_index_prefix} {reads} | \
                         samtools view -bS - | \
                         samtools sort -o - - | \
                         tee {temp}"
                         .format(bwa_index_prefix=bwa_index_prefix, reads=args.reads, temp=temp_out.name),
                         shell=True, stdout=STDOUT, stderr=STDERR, executable='/bin/bash'
                         )
        if args.out:
            subprocess.call("samtools index %s %s.bai" % (temp_out.name, args.out), 
                shell=True, stderr=STDERR, executable='/bin/bash')
    else:
        # Align reads > SAM stdout
        subprocess.call(["bwa", "mem", "-v=0", bwa_index_prefix, args.reads], stdout=STDOUT, stderr=STDERR)