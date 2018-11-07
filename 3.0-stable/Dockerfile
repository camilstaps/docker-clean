FROM camilstaps/clean:base
MAINTAINER Camil Staps <info@camilstaps.nl>

RUN PACKAGES="curl make subversion ca-certificates" \
	PERSISTENT_PACKAGES="gcc" \
	&& apt-get update \
	&& apt-get install -qq $PACKAGES $PERSISTENT_PACKAGES --no-install-recommends \
# Install Clean
	&& curl -sSL https://ftp.cs.ru.nl/Clean/Clean30/linux/clean3.0_64.tar.gz \
		| tar --strip-components=1 -xz \
	&& make \
# clean up
	&& apt-get remove --purge $PACKAGES -qq \
	&& apt-get autoremove --purge -qq \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
