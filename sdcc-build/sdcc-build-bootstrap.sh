#!/bin/bash
# Simple shell script that knows enough to download the sdcc build scripts
# and start them running.

BUILDROOT=$HOME/build
#test -z $BUILDROOT && \
#  BUILDROOT=/var/tmp/$(whoami)/build

HOMEBUILD=$HOME/build
BUILDDATE=$(date +%Y%m%d)

# A lockfile ensures, that the cronjobs of the different hosts don't overlap.

# uniq id
MYID=$HOSTNAME
# time to sleep until next check of lockfile, in seconds
SLEEP=60
# maximum age of lockfile; after this the lock will be removed
MAXMINUTES=120
# filename of lock
LOCKFILE=$BUILDROOT/sdcc-build.lock
# prefix for all messages, which is used to filter the messages out of the buildlogs
MSGPREFIX="Buildlock: "

# Delete lockfile
# but check first, if it's (still) our own lockfile.
cleanup ()
{
  echo $MSGPREFIX cleanup
  test -f $LOCKFILE && head -n 1 $LOCKFILE | grep $MYID > /dev/null && rm $LOCKFILE
}

trap 'echo $MSGPREFIX caught signal ; cleanup ; exit 1' 1 2 3 13 15

mkdir -p $BUILDROOT

echo $MSGPREFIX Try to obtain lock on `date`
test -f $LOCKFILE && echo -n $MSGPREFIX && ls -l --full-time $LOCKFILE
while (true); do
{
  if test -f $LOCKFILE; then
  {
    sleep $SLEEP
    find $LOCKFILE -mmin +$MAXMINUTES \
         -exec echo $MSGPREFIX lock from \"`cat $LOCKFILE`\" expired \; \
         -exec rm -f {} \;
  }
  else
  {
    echo $MYID > $LOCKFILE
    # check, if we're in the first line of lockfile;
    # if we're not in the first line, another host was faster
    # and we have to wait again.
    head -n 1 $LOCKFILE | grep $MYID > /dev/null || continue
    echo $MSGPREFIX "Obtained lock on     " `date`
    break
  }
  fi
}
done

SVNROOT=https://sdcc.svn.sourceforge.net/svnroot/sdcc/trunk
# -s for quiet operation so that this can be run from a cronjob
MAKEFLAGS=
# Include local apps.
if [ -d ~/local-$HOSTNAME/bin ] ; then
  PATH=$PATH:$HOME/local-$HOSTNAME/bin
elif [ -d ~/local/bin ] ; then
  PATH=$PATH:$HOME/local/bin
fi

# Checkout the latest sdcc-build version to $BULDROOT/sdcc-build
rm -rf $BULDROOT/sdcc-build
svn checkout $SVNROOT/sdcc-build $BUILDROOT/sdcc-build

# And spawn onto the actual build
cd $BUILDROOT/sdcc-build
make $MAKEFLAGS crontab-spawn $EXTRATARGETS do-upload remove-old-versions

# cp log files from local hd to $HOMEBUILD on nfs server
test $BUILDROOT != $HOMEBUILD && \
  cp -p ../*.log ../*.filtered $HOMEBUILD/

cleanup
