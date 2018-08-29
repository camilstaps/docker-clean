#!/bin/bash

# Usage: install_clean.sh 'TARGET1 TARGET2 ..' DATE
# Where TARGETs are e.g. bundle-complete (see http://ftp.cs.ru.nl/Clean/builds/linux-x64/)
# And DATE is an optional date to check the libraries out

TARGETS="$1"
DATE="$2"

if [ "$DATE" != "" ]; then
	export CLEANDATE="$DATE"
fi

PACKAGES="gcc make subversion git ca-certificates curl rsync"
apt-get update -qq
apt-get install -qq $PACKAGES --no-install-recommends
rm -rf /var/lib/apt/lists/*

cd /tmp
git clone https://gitlab.science.ru.nl/clean-and-itasks/clean-build
sed -i 's/http.*/https:\/\/ftp.cs.ru.nl\/Clean\/builds\/linux-x64\/clean-classic-linux-x64-latest.tgz/' clean-build/clean-base/linux-x64/setup.sh
sed -i 's/git checkout\(.*\)/(cd src\/$repo; git checkout\1)/' clean-build/generic/fetch.sh
sed -i 's/\.\/build\.sh/.\/build.sh || true/' clean-build/generic/setup.sh

for TARGET in $TARGETS
do
	(cd "clean-build/clean-$TARGET/linux-x64"

		./fetch.sh
		./setup.sh
		./build.sh

		rsync -r target/clean-$TARGET/* /opt/clean)
done

rm -rf clean-build
