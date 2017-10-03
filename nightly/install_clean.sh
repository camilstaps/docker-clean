#!/bin/bash

# Usage: install_clean.sh TARGET DATE
# Where TARGET is e.g. bundle-complete (see ftp://ftp.cs.ru.nl/pub/Clean/builds/linux-x64/)
# And DATE is an optional date to check the libraries out

TARGET="$1"
DATE="$2"

export CLEANDATE="$DATE"

PACKAGES="gcc make subversion git ca-certificates curl rsync"
apt-get update -qq
apt-get install -qq $PACKAGES --no-install-recommends

cd /tmp
git clone -b build-by-date https://gitlab.science.ru.nl/cstaps/clean-build
cd "clean-build/clean-$TARGET/linux-x64"

./fetch.sh
./setup.sh
./build.sh
mv "target/clean-$TARGET" /opt/clean

cd /tmp
rm -rf clean-build

apt-get remove --purge $PACKAGES -qq
apt-get autoremove --purge -qq
rm -rf /var/lib/apt/lists/*
