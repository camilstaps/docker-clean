#!/bin/bash

# Usage: install_clean.sh 'TARGET1 TARGET2 ..' DATE
# Where TARGETs are e.g. bundle-complete (see http://ftp.cs.ru.nl/Clean/builds/linux-x64/)
# And DATE is an optional date to check the libraries out
#
# Optionally set CLEAN_OS (default linux) and/or CLEAN_PLATFORM (default x64).

TARGETS="$1"
DATE="$2"

if [ "$DATE" != "" ]; then
	export CLEANDATE="$DATE"
fi

PACKAGES="curl gcc git make rsync subversion unzip"
if [[ "$CLEAN_PLATFORM" == "x86" ]]; then
	dpkg --add-architecture i386
	PACKAGES="$PACKAGES gcc-multilib libc6-i386"
fi
apt-get update -qq
apt-get install -qq $PACKAGES --no-install-recommends
rm -rf /var/lib/apt/lists/*

cd /tmp
git clone https://gitlab.com/camilstaps/clean-build
cd clean-build
[ ! -z "$CLEANDATE" ] && git checkout `git rev-list -n 1 --before="$CLEANDATE" main`
[ ! -z "$PATCHCLEANBUILD" ] && eval $PATCHCLEANBUILD

if [[ -z "$CLEAN_OS" ]]; then
	CLEAN_OS="linux"
fi
if [[ -z "$CLEAN_PLATFORM" ]]; then
	CLEAN_PLATFORM="x64"
fi

for TARGET in $TARGETS
do
	./generic/fetch.sh clean-$TARGET $CLEAN_OS $CLEAN_PLATFORM
	./generic/setup.sh clean-$TARGET $CLEAN_OS $CLEAN_PLATFORM
	./generic/build.sh clean-$TARGET $CLEAN_OS $CLEAN_PLATFORM

	rsync -r target/clean-$TARGET/* /opt/clean
done

cd /tmp
rm -rf clean-build
