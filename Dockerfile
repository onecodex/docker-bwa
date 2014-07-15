FROM quay.io/refgenomics/docker-ubuntu:14.04

MAINTAINER Nik Krumm <nkrumm@gmail.com>

RUN git clone https://github.com/lh3/bwa && \
	cd bwa && \
	git checkout 0.7.10 &&  \
	make && cp bwa /usr/local/bin/bwa


CMD ["/usr/local/bin/bwa"]

# Integration tests
ADD test /tmp/test
RUN bats /tmp/test
