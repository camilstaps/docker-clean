#!/bin/bash

PACKAGES="gcc make subversion git ca-certificates curl rsync"
apt-get remove --purge $PACKAGES -qq
apt-get autoremove --purge -qq
rm -rf /opt/clean
