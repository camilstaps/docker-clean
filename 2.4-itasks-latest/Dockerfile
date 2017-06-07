FROM camilstaps/clean:base
MAINTAINER Camil Staps <info@camilstaps.nl>

RUN PACKAGES="curl gcc make subversion ca-certificates git" \
	&& apt-get update \
	&& apt-get install -qq $PACKAGES --no-install-recommends \
# Install Clean
	&& curl -sSL http://ftp.cs.ru.nl/Clean/nightly/clean-itasks-linux64-20161024.tar.gz \
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
# Latest clean-platform
	&& cd /tmp\
	&& git clone https://gitlab.science.ru.nl/clean-and-itasks/clean-platform.git \
	&& rm -rf /opt/clean/lib/clean-platform \
	&& cp -R clean-platform/src/libraries /opt/clean/lib/clean-platform \
	&& rm -rf clean-platform \
# clean up
	&& apt-get remove --purge $PACKAGES -qq \
	&& apt-get autoremove --purge -qq \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
