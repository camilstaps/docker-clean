#!/bin/bash

# Usage: install_clean.sh 'TARGET1 TARGET2 ..' DATE
# Where TARGETs are e.g. bundle-complete (see http://ftp.cs.ru.nl/Clean/builds/linux-x64/)
# And DATE is an optional date to check the libraries out

TARGETS="$1"
DATE="$2"

if [ "$DATE" != "" ]; then
	export CLEANDATE="$DATE"
fi

PACKAGES="gcc make subversion git ca-certificates curl rsync unzip"
apt-get update -qq
apt-get install -qq $PACKAGES --no-install-recommends
rm -rf /var/lib/apt/lists/*

cd /tmp
git clone --branch docker https://gitlab.science.ru.nl/clean-and-itasks/clean-build
cd clean-build
[ ! -z "$CLEANDATE" ] && git checkout `git rev-list -n 1 --before="$CLEANDATE" docker`
[ ! -z "$PATCHCLEANBUILD" ] && eval $PATCHCLEANBUILD

for TARGET in $TARGETS
do
	./generic/fetch.sh clean-$TARGET linux x64
	./generic/setup.sh clean-$TARGET linux x64
	./generic/build.sh clean-$TARGET linux x64

	rsync -r target/clean-$TARGET/* /opt/clean
done

cd /tmp
rm -rf clean-build
