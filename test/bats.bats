#!/usr/bin/env bats

@test "It should have bwa and samtools installed" {
  which bwa
  which samtools
}

@test "Bwa should index a test genome" {
  bwa index /tmp/test/test.fasta
}

@test "Bwa should map some test reads" {
  bwa mem /tmp/test/test.fasta /tmp/test/test.fastq 2> /dev/null 1> /tmp/test/test.out.sam
  run diff /tmp/test/test.sam /tmp/test/test.out.sam
  [[ "$output" = "" ]]
}

@test "Samtools should create a bam and sort it" {
  samtools view -bS /tmp/test/test.out.sam > /tmp/test/test.out.bam
  samtools sort /tmp/test/test.out.bam /tmp/test/test.out.sorted
  run diff /tmp/test/test.out.sorted.bam /tmp/test/test.sorted.bam
  [[ "$output" = "" ]]
}

@test "align.py should index, map and output an alignment" {
  run align.py /tmp/test/test.fasta /tmp/test/test.fastq --sam --out /tmp/test/align_out.sam
  run diff <(cat /tmp/test/test.sam | grep -v "^@") <(cat /tmp/test/align_out.sam | grep -v "^@")
  [[ "$output" = "" ]] 
}