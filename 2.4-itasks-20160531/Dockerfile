FROM camilstaps/clean:base
MAINTAINER Camil Staps <info@camilstaps.nl>

RUN curl -sSL ftp://ftp.cs.ru.nl/pub/Clean/nightly/clean-itasks-linux64-20160531.tar.gz \
	 | tar --strip-components=1 -xz \
	&& make

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
