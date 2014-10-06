# docker-bwa

[![Docker Repository on Quay.io](https://quay.io/repository/refgenomics/docker-bwa/status?token=9830b435-9661-4ac4-b1d9-9bd0f264fc30 "Docker Repository on Quay.io")](https://quay.io/repository/refgenomics/docker-bwa)

BWA mapping tools and samtools

## Installation

    docker pull quay.io/refgenomics/docker-bwa
    docker run  quay.io/refgenomics/docker-bwa

## The `align` convenience command

Included in this docker container is the `align.py` convience pipeline. This script integrates the indexing, mapping, and sam->sorted bam output in one command. `align` can be invoked by running the `align` command in the container:

    $ docker run quay.io/refgenomics/docker-bwa align

Usage and help is available:

    $ docker run quay.io/refgenomics/docker-bwa align --help
    usage: align [-h] [-b | -s] [-o OUT] [--verbose]
                 references [references ...] reads

    positional arguments:
      references         Reference FASTA file(s) used for alignment
      reads              Reads FASTA or FASTQ file to be aligned

    optional arguments:
      -h, --help         show this help message and exit
      -b, --bam          Output a bam file
      -s, --sam          Output a bam file
      -o OUT, --out OUT  Output file or destination (default is stdout)
      --verbose          Output stderr from commands

As an example, you can quickly align a set of reads to a fasta file like so:

    docker run -v ~/local:/data quay.io/refgenomics/docker-bwa align \
        data/genome.fa \
        /data/reads.fa --sam

An the resuling sam file will be output to stdout. 

To create a sorted bam file (and index):

    docker run -v ~/local:/data quay.io/refgenomics/docker-bwa align \
        data/genome.fa \
        /data/reads.fa --bam \
        --out /data/output.bam

## Available binaries

### BWA

This image contains [BWA-mem v0.7.10](https://github.com/lh3/bwa). To run:

    docker run quay.io/refgenomics/docker-bwa bwa [bwa-options]

### Samtools

This image contains [samtools `0.1.19-96b5f2294a`](https://github.com/samtools/samtools). To run:

    docker run quay.io/refgenomics/docker-bwa samtools [samtools-options]


## Copyright and License

MIT License, see [LICENSE](LICENSE.md) for details.

Copyright (c) 2014 [One Codex](https://www.onecodex.com), [Nik Krumm](https://github.com/nkrumm), and contributors.
