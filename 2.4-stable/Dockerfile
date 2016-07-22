FROM camilstaps/clean:base
MAINTAINER Camil Staps <info@camilstaps.nl>

RUN curl -sSL http://clean.cs.ru.nl/download/Clean24/linux/clean2.4_64.tar.gz \
	 | tar --strip-components=1 -xz \
	&& make

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
