#!/bin/sh
# Simple shell script that knows enough to download the sdcc build scripts
# and start them running.

MODULE=sdcc-build
CVSROOT=:pserver:anonymous@cvs.sdcc.sourceforge.net:/cvsroot/sdcc
BUILDROOT=$HOME/build
# -s for quiet operation so that this can be run from a cronjob
MAKEFLAGS=-s

# Remove the old version
rm -rf $BUILDROOT/$MODULE

# Checkout the latest version
cd $BUILDROOT
cvs -Q -d$CVSROOT co $MODULE

# And spawn onto the actual build
cd $BUILDROOT/$MODULE
exec make $MAKEFLAGS
