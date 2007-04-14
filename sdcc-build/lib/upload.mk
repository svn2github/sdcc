# Makefile that uploades everything from $(HTDOCSDIR) to $(_WEBSNAPSHOTDEST)

_WEBSNAPSHOTDIR=$(WEBHTDOCSDIR)/$(TARBALLBASE)
_WEBREGTESTDIR=$(WEBHTDOCSDIR)/$(REGTESTBASE)
_WEBCHANGELOGDIR=$(WEBHTDOCSDIR)/changelog_heads

# Location to copy the tarball to
_WEBSNAPSHOTDEST=$(WEBUSER)@$(WEBHOST):$(WEBHTDOCSDIR)

.PHONY: do-upload remove-old-versions
do-upload:
	# copy files to the destination
	# make all files writable and searchable by group members on the destination
	# and remove them from source
	cd $(HTDOCSDIR); \
	DIR_LIST=$$(find * -type d -print 2>/dev/null); \
	FILE_LIST=$$(find * -type f -print 2>/dev/null); \
	if test -n "$$FILE_LIST"; \
	then \
	  rsync --relative --include='*.exe' -e ssh --size-only $$FILE_LIST $(_WEBSNAPSHOTDEST) && \
	  { \
	    ssh $(WEBUSER)@$(WEBHOST) cd $(WEBHTDOCSDIR)\; chmod g+wx $$DIR_LIST\; chmod g+w $$FILE_LIST\; \
	    rm -rf $(HTDOCSDIR)/*; \
	  }; \
	fi

# Removes old versions
remove-old-versions:
# over seven days old
#	ssh $(WEBHOST) 'cd $(_WEBSNAPSHOTDIR); find . -mtime +7 -not -type d -exec rm {} \;'
# more than 7 files in dir
	ssh $(WEBHOST) 'find $(_WEBSNAPSHOTDIR)/* $(_WEBREGTESTDIR)/* $(_WEBCHANGELOGDIR) -type d -exec sh -c "cd {} ; ls -1t | sed 1,7d | xargs rm -f" \;'
