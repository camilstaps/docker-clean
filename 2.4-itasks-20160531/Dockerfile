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

RUN curl -sSL ftp://ftp.cs.ru.nl/pub/Clean/nightly/clean-itasks-linux64-20160531.tar.gz \
	 | tar --strip-components=1 -xz \
	&& make

ENV PATH /opt/clean/bin:/opt/clean/exe:$PATH

WORKDIR /root

ENTRYPOINT ["clm"]
CMD ["-h"]
