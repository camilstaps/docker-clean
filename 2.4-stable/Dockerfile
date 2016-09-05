FROM camilstaps/clean:base
MAINTAINER Camil Staps <info@camilstaps.nl>

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		subversion ca-certificates\
	&& apt-get clean && apt-get autoclean \
	&& rm -rf /var/lib/apt/lists/*

RUN curl -sSL http://clean.cs.ru.nl/download/Clean24/linux/clean2.4_64.tar.gz \
	 | tar --strip-components=1 -xz \
	&& make

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