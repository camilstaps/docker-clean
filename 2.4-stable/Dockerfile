FROM camilstaps/clean:base
MAINTAINER Camil Staps <info@camilstaps.nl>

RUN PACKAGES="curl make subversion" \
	PERSISTENT_PACKAGES="gcc" \
	&& apt-get update \
	&& apt-get install -qq $PACKAGES $PERSISTENT_PACKAGES --no-install-recommends \
# Install Clean
	&& curl -sSL https://ftp.cs.ru.nl/Clean/Clean24/linux/clean2.4_64.tar.gz \
		| tar --strip-components=1 -xz \
	&& make \
# Latest clm
	&& cd /tmp \
	&& svn co https://svn.cs.ru.nl/repos/clean-tools/trunk/clm \
	&& cd clm \
	&& make -f Makefile.linux64 clm patch_bin \
	&& ./patch_bin clm CLEANLIB $CLEAN_HOME/exe \
	&& ./patch_bin clm CLEANPATH $CLEAN_HOME/lib/StdEnv \
	&& cp clm /opt/clean/bin/clm \
	&& cd /opt/clean \
	&& rm -r /tmp/clm \
# clean up
	&& apt-get remove --purge $PACKAGES -qq \
	&& apt-get autoremove --purge -qq \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
