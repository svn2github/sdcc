# Makefile that uploades everything from $(HTDOCSDIR) to $(_WEBSNAPSHOTDEST)

_WEBSNAPSHOTDIR=$(WEBHTDOCSDIR)/$(TARBALLBASE)
_WEBREGTESTDIR=$(WEBHTDOCSDIR)/$(REGTESTBASE)
_WEBCHANGELOGDIR=$(WEBHTDOCSDIR)/changelog_heads

# Location to copy the tarball to
_WEBSNAPSHOTDEST=$(WEBUSER)@$(WEBHOST):$(WEBHTDOCSDIR)

.PHONY: do-upload remove-old-versions
do-upload:
	# make all files wtitable and searchable by group members
	find $(HTDOCSDIR) -type d -exec chmod g+wx {} \;
	find $(HTDOCSDIR) -type f -exec chmod g+w {} \;
	# copy files
	rsync --recursive --perms --include='*.exe' -e ssh --size-only $(HTDOCSDIR)/* $(_WEBSNAPSHOTDEST) && \
	rm -rf $(HTDOCSDIR)/*

# Removes old versions
remove-old-versions:
# over seven days old
#	ssh $(WEBHOST) 'cd $(_WEBSNAPSHOTDIR); find . -mtime +7 -not -type d -exec rm {} \;'
# more than 7 files in dir
	ssh $(WEBHOST) 'find $(_WEBSNAPSHOTDIR)/* $(_WEBREGTESTDIR)/* $(_WEBCHANGELOGDIR) -type d -exec sh -c "cd {} ; ls -1t | sed 1,7d | xargs rm -f" \;'
