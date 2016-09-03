FROM debian:jessie
MAINTAINER Camil Staps <info@camilstaps.nl>

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		curl \
		gcc \
		libc6-dev \
		make \
	&& apt-get clean && apt-get autoclean \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/clean
WORKDIR /opt/clean

ENV CLEAN_HOME /opt/clean
ENV PATH /opt/clean/bin:/opt/clean/exe:$PATH

ENTRYPOINT ["clm"]
CMD ["-h"]
