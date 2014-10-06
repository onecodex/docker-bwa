FROM quay.io/refgenomics/docker-ubuntu:14.04

MAINTAINER Nik Krumm <nkrumm@gmail.com>

RUN git clone https://github.com/lh3/bwa && \
	cd bwa && \
	git checkout 0.7.10 &&  \
	make && cp bwa /usr/local/bin/bwa

RUN apt-get install -y samtools

# Convenience commands
ADD align.py /usr/local/bin/align.py
RUN chmod +x /usr/local/bin/align.py
RUN ln -s /usr/local/bin/align.py /usr/local/bin/align
CMD ["/usr/local/bin/align"]

# Integration tests
ADD test /tmp/test
RUN bats /tmp/test
