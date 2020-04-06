#!/bin/bash

PACKAGES="gcc make subversion git ca-certificates curl rsync"
if [[ "$CLEAN_PLATFORM" == "x86" ]]; then
	PACKAGES="$PACKAGES gcc-multilib"
fi
apt-get remove --purge $PACKAGES -qq
apt-get autoremove --purge -qq
rm -rf /opt/clean
