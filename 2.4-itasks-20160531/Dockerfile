FROM camilstaps/clean:base
MAINTAINER Camil Staps <info@camilstaps.nl>

RUN apt-get update && apt-get install -qq subversion ca-certificates

# Install Clean
RUN curl -sSL http://ftp.cs.ru.nl/Clean/nightly/clean-itasks-linux64-20160531.tar.gz \
		| tar --strip-components=1 -xz \
	&& make

# Latest clm
RUN cd /tmp\
	&& svn co https://svn.cs.ru.nl/repos/clean-tools/trunk/clm\
	&& cd clm\
	&& make -f Makefile.linux64 clm patch_bin\
	&& ./patch_bin clm CLEANLIB $CLEAN_HOME/exe\
	&& ./patch_bin clm CLEANPATH $CLEAN_HOME/lib/StdEnv\
	&& cp clm /opt/clean/bin/clm\
	&& cd /opt/clean\
	&& rm -r /tmp/clm

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
