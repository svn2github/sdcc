#!/bin/sh
# Simple shell script that knows enough to download the sdcc build scripts
# and start them running.

MODULE=sdcc-build
CVSROOT=:pserver:anonymous@cvs.sdcc.sourceforge.net:/cvsroot/sdcc
BUILDROOT=$HOME/build
# -s for quiet operation so that this can be run from a cronjob
MAKEFLAGS=
# Include local apps.
PATH=$PATH:$HOME/local/bin

# Remove the old version
rm -rf $BUILDROOT/$MODULE

# Checkout the latest version
cd $BUILDROOT
cvs -Q -d$CVSROOT co $MODULE

# Setup the ssh keys
# Not needed as an empty key is automatically read.
#eval `ssh-agent`
#export SSH_AGENT_PID
#export SSH_AUTH_SOCK
#ssh-add

# And spawn onto the actual build
cd $BUILDROOT/$MODULE
exec make $MAKEFLAGS crontab-spawn

