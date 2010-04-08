#!/bin/sh

# dcf.sh - Distributed Compile Farm Mediator
#
# Copyright (c) 2007-2010 Borut Razem
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

LOG_LINES=1000
BWLIMIT=7	# bandwith limit for rsync

ETC_DIR=$HOME/etc
LOG_DIR=$HOME/log
LOCK_DIR=$HOME/lock

DCF_BUILDER_LIST_FILE=$ETC_DIR/dcf_list
DCF_LOG=$LOG_DIR/dcf.log
DCF_LOCK=$LOCK_DIR/dcf.lock

mkdir -p $LOG_DIR $LOCK_DIR

WEBHOST=web.sourceforge.net
WEBUSER=sdcc-builder,sdcc
WEBHTDOCSDIR=/home/groups/s/sd/sdcc/htdocs


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
    if test -e $DCF_LOG -a $(echo "$LOG" | wc -l) -lt $LOG_LINES
    then
      LOG=$(echo -e "$LOG\n" | cat - $DCF_LOG | head -n $LOG_LINES)
    fi
    echo "$LOG" > $DCF_LOG
  fi
}


# remove more than 7 files in dir from WEB server
rm_old_versions ()
{
  local i j k

  for i in htdocs/snapshots htdocs/regression_test_results
  do    
    for j in $(echo "ls -1t $i" | sftp -b- ${WEBUSER}@${WEBHOST} | sed -e '/^sftp> /d')
    do    
      for k in $(echo "ls -1t $j" | sftp -b- ${WEBUSER}@${WEBHOST} | sed -e '/^sftp> /d' | sed -e '1,7d')
      do
        if [ -n "$k" ]; then echo "removing $k"; echo "rm $k" | sftp -b- ${WEBUSER}@${WEBHOST}; fi
      done
    done
  done

  for k in $(echo "ls -1t htdocs/changelog_heads" | sftp -b- ${WEBUSER}@${WEBHOST} | sed -e '/^sftp> /d' | sed -e '1,7d')
  do
    if [ -n "$k" ]; then echo "removing $k"; echo "rm $k" | sftp -b- ${WEBUSER}@${WEBHOST}; fi
  done
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
    lockfile -r 0 $DCF_LOCK || exit 1

    test "$BWLIMIT" != "" && RSYNC_OPTS="$RSYNC_OPTS --bwlimit=$BWLIMIT"

    {
      while read -r builder
      do
        export builder
        (
          builder=$(echo $builder | sed "s/^\(.*\)#.*$/\1/")
          if test ! -z "$builder"
          then
            if cd /home/$builder/htdocs
            then
              FILE_LIST=$(find * -depth -print 2>/dev/null)
              if test -n "$FILE_LIST"
              then
                echo "+++ start: $(date)"
                echo "=== files in /home/$builder/htdocs:"
                list_files $FILE_LIST

                echo "=== rsyncing..."
                rsync $RSYNC_OPTS --relative --include='*.exe' -e ssh --size-only $FILE_LIST $WEBUSER@$WEBHOST:$WEBHTDOCSDIR/ 2>&1 | grep -v -e "skipping directory"

                echo "=== removing..."
                rm_list $FILE_LIST

                echo "=== removing old versions..."
                rm_old_versions

                echo "--- end: $(date)"
              fi
            fi
          fi
        )
      done
    } < $DCF_BUILDER_LIST_FILE
  fi

  cleanup
} 2>&1 | log_it

exit 0
