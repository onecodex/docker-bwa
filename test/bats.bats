#!/usr/bin/env bats

@test "It should have bwa installed" {
  which bwa
}

@test "Bwa should index a test genome" {
  bwa index /tmp/test/test.fasta
}

@test "Bwa should map some test reads" {
  bwa mem /tmp/test/test.fasta /tmp/test/test.fastq 2> /dev/null 1> /tmp/test/test.out.sam
  diff /tmp/test/test.sam /tmp/test/test.out.sam
  
}
