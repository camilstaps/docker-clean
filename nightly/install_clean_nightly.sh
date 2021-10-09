#!/bin/bash

# Usage: install_clean_nightly.sh TARGET [TARGET ...]
# Where TARGET is e.g. bundle-complete (see http://ftp.cs.ru.nl/Clean/builds/linux-x64/)
#
# Optionally set CLEAN_OS (default linux) and/or CLEAN_PLATFORM (default x64).

echo
echo "WARNING: make sure this image does not get cached by Docker to ensure you have the latest nightly!"
echo

PACKAGES="curl gcc"
if [[ "$CLEAN_PLATFORM" == "x86" ]]; then
	PACKAGES="$PACKAGES libc6-i386"
fi
apt-get update -qq
apt-get install -qq $PACKAGES --no-install-recommends
rm -rf /var/lib/apt/lists/*

mkdir -p /opt/clean

if [[ -z "$CLEAN_OS" ]]; then
	CLEAN_OS="linux"
fi
if [[ -z "$CLEAN_PLATFORM" ]]; then
	CLEAN_PLATFORM="x64"
fi

for TARGET in $@; do
	curl https://ftp.cs.ru.nl/Clean/builds/$CLEAN_OS-$CLEAN_PLATFORM/clean-$TARGET-$CLEAN_OS-$CLEAN_PLATFORM-latest.tgz \
		| tar xz --strip-components=1 -C /opt/clean
done
