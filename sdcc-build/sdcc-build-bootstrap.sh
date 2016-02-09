#!/bin/sh

# Simple shell script that knows enough to download the sdcc build scripts
# and start them running.

BUILDROOT=$HOME/build
#test -z $BUILDROOT && \
#  BUILDROOT=/var/tmp/`whoami`/build

# SVN sdcc-build repository
SVNROOT=svn://svn.code.sf.net/p/sdcc/code/trunk

BUILDDATE=`date +%Y%m%d`

# The lockfile ensures that the new build doesn't start until the previous one s not done

# uniq id
MYID=$HOSTNAME
# time to sleep until next check of lockfile, in seconds
SLEEP=60
# maximum age of lockfile; after this the lock will be removed
MAXMINUTES=1440 #one day
# filename of lock
LOCKFILE=$BUILDROOT/sdcc-build.lock
# prefix for all messages, which is used to filter the messages out of the buildlogs
MSGPREFIX="Buildlock: "

# Delete lockfile
# but check first, if it's (still) our own lockfile.
cleanup ()
{
  echo $MSGPREFIX cleanup
  test -f $LOCKFILE && head -n 1 $LOCKFILE | grep $MYID > /dev/null && rm $LOCKFILE && echo $MSGPREFIX "Lock released on     " `date`
}

# Execute supported version of ls -l --full-time
ls_l_full_time ()
{
  # test if ls -l --full-time is supported
  res=`ls -l --full-time $1 2>&1`
  if test $? = 0; then
    # ls -l --full-time supported: echo the result
    echo "$res"
  else
    # ls -l --full-time not supported: execute ls -l
    ls -l $1
  fi
}

# Perform locking
do_lock ()
{
  echo $MSGPREFIX Try to obtain lock on `date`
  test -f $LOCKFILE && printf "%s %s\n" $MSGPREFIX "`ls_l_full_time $LOCKFILE`"
  while true
  do
    if test -f $LOCKFILE
    then
      sleep $SLEEP
      res=`find $LOCKFILE -mmin +$MAXMINUTES \
           -exec echo $MSGPREFIX lock from \`cat $LOCKFILE\` expired \; \
           -exec rm -f {} \; 2> /dev/null`
      if test $? = 0; then
        echo $res
      else
        echo $MSGPREFIX "Can't obtain the lock"
        return 1
      fi
    else
      echo $MYID > $LOCKFILE
      # check, if we're in the first line of lockfile;
      # if we're not in the first line, another host was faster
      # and we have to wait again.
      head -n 1 $LOCKFILE | grep $MYID > /dev/null || continue
      echo $MSGPREFIX "Obtained lock on     " `date`
      break
    fi
  done

  return 0
}

trap 'echo $MSGPREFIX caught signal ; cleanup ; exit 1' 1 2 3 13 15

mkdir -p $BUILDROOT

if do_lock
then
  success=0
  # Include local apps.
  if test -d ~/local-$HOSTNAME/bin; then
    PATH=$PATH:$HOME/local-$HOSTNAME/bin
  elif test -d ~/local/bin; then
    PATH=$PATH:$HOME/local/bin
  fi

  for i in 0 1 2
  do
    # Checkout the latest sdcc-build version to $BUILDROOT/sdcc-build
    # Quick & dirty temporary fix: don't remove the build if uploading
    test "$1" != "do-upload" && rm -rf $BUILDROOT/sdcc-build
    if svn checkout $SVNROOT/sdcc-build $BUILDROOT/sdcc-build
    then
      success=1
      break
    else
      sleep 5m
    fi
  done

  if test "$success" = 1
  then
    # Spawn onto the actual build
    # Don't use "make -C" to change directory since the "Entering directory" and
    # "Leaving directory" messages are displayed in the regression test results
    cd $BUILDROOT/sdcc-build
    make $*
  else
    echo $MSGPREFIX "can't checkout"
  fi
fi

cleanup
