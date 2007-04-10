#!/bin/sh

# dcf.sh - Distributed Compile Farm Mediator
#
# Copyright (c) 2007 Borut Razem
#
# This file is part of sdcc.
#
#  This software is provided 'as-is', without any express or implied
#  warranty.  In no event will the authors be held liable for any damages
#  arising from the use of this software.
#
#  Permission is granted to anyone to use this software for any purpose,
#  including commercial applications, and to alter it and redistribute it
#  freely, subject to the following restrictions:
#
#  1. The origin of this software must not be misrepresented; you must not
#     claim that you wrote the original software. If you use this software
#     in a product, an acknowledgment in the product documentation would be
#     appreciated but is not required.
#  2. Altered source versions must be plainly marked as such, and must not be
#     misrepresented as being the original software.
#  3. This notice may not be removed or altered from any source distribution.
#
#  Borut Razem
#  borut.razem@siol.net

LOG_LINES=100

ETC_DIR=$HOME/etc
LOG_DIR=$HOME/log
LOCK_DIR=$HOME/lock

DCF_BUILDER_LIST_FILE=$ETC_DIR/dcf_list
DCF_LOG=$LOG_DIR/dcf.log
DCF_LOCK=$LOCK_DIR/dcf.lock

mkdir -p $LOG_DIR $LOCK_DIR

WEBHOST=shell.sf.net
WEBUSER=sdcc-builder
WEBHTDOCSDIR=/home/groups/s/sd/sdcc/htdocs

WEBSNAPSHOTDIR=$WEBHTDOCSDIR/snapshots
WEBREGTESTDIR=$WEBHTDOCSDIR/regression_test_results
WEBCHANGELOGDIR=$WEBHTDOCSDIR/changelog_heads


# remove files & directories specified in arguments
# relays on find -depth
rm_list ()
{
  for file in $*
  do
    if test -d $file
    then
      rmdir $file
    else
      rm -f $file
    fi
  done
}


# list files & directories specified in arguments
# each file in a new line
list_files ()
{
  for file in $*
  do
    echo "  $file"
  done
}


# write the standard input to beginning of the log file
# and truncate it to $LOG_LINES lines
log_it ()
{
  local LOG=$(cat)

  if test -n "$LOG"
  then
    if test $(echo "$LOG" | wc -l) -lt $LOG_LINES
    then
      LOG=$(echo -e "$LOG\n" | cat - $DCF_LOG | head -n $LOG_LINES)
    fi
    echo "$LOG" > $DCF_LOG
  fi
}


# remove more than 7 files in dir from WEB server
rm_old_versions ()
{
  ssh $WEBUSER@$WEBHOST "find $WEBSNAPSHOTDIR/* $WEBREGTESTDIR/* $WEBCHANGELOGDIR -type d -exec sh -c 'cd {} ; ls -1t | sed 1,7d | xargs rm -f' \\;"
}


# cleanup the lock file
cleanup ()
{
  rm -f $DCF_LOCK
}


{
  trap 'echo dcf.sh caught signal ; cleanup ; exit 1' 1 2 3 13 15

  if test -e $DCF_BUILDER_LIST_FILE
  then
    BUILDER_LIST=$(cat $DCF_BUILDER_LIST_FILE)
  fi

  lockfile -r 0 $DCF_LOCK >/dev/null 2>&1 || exit 1

  for builder in $BUILDER_LIST
  do
    (
      cd /home/$builder/htdocs
      FILE_LIST=$(find * -depth -print 2>/dev/null)
      if test -n "$FILE_LIST"
      then
        echo "+++ start: $(date)"
        echo "rsyncing /home/$builder/htdocs:"
        list_files $FILE_LIST

        rsync --relative --include='*.exe' -e ssh --size-only $FILE_LIST $WEBUSER@$WEBHOST:$WEBHTDOCSDIR/ 2>&1 | grep -v -e "skipping directory"

        rm_list $FILE_LIST

        echo "--- end: $(date)"
      fi
    )
  done

  rm_old_versions
} 2>&1 | log_it

cleanup

exit 0
