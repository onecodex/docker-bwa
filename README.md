# docker-bwa

[![Docker Repository on Quay.io](https://quay.io/repository/refgenomics/docker-bwa/status?token=9830b435-9661-4ac4-b1d9-9bd0f264fc30 "Docker Repository on Quay.io")](https://quay.io/repository/refgenomics/docker-bwa)

BWA mapping tools and samtools

## Installation

    docker pull quay.io/refgenomics/docker-bwa
    docker run  quay.io/refgenomics/docker-bwa

## Available binaries

### BWA

This image contains [BWA-mem v0.7.10](https://github.com/lh3/bwa). To run:

    docker run quay.io/refgenomics/docker-bwa bwa [bwa-options]

### Samtools

This image contains [samtools `0.1.19-96b5f2294a`](https://github.com/samtools/samtools). To run:

    docker run quay.io/refgenomics/docker-bwa samtools [samtools-options]


## Copyright and License

MIT License, see [LICENSE](LICENSE.md) for details.

Copyright (c) 2014 [Helix I/O](https://www.helix.io), [Nik Krumm](https://github.com/nkrumm), and contributors.
