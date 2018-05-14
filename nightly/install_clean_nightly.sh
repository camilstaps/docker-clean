#!/bin/bash

# Usage: install_clean_nightly.sh TARGET [TARGET ...]
# Where TARGET is e.g. bundle-complete (see http://ftp.cs.ru.nl/Clean/builds/linux-x64/)

echo
echo "WARNING: make sure this image does not get cached by Docker to ensure you have the latest nightly!"
echo

PACKAGES="ca-certificates curl"
apt-get update -qq
apt-get install -qq $PACKAGES --no-install-recommends
rm -rf /var/lib/apt/lists/*

mkdir -p /opt/clean

for TARGET in $@; do
	curl https://ftp.cs.ru.nl/Clean/builds/linux-x64/clean-$TARGET-linux-x64-latest.tgz \
		| tar xz --strip-components=1 -C /opt/clean
done
