# Makefile that uploades everything from $(HTDOCSDIR) to $(_WEBSNAPSHOTDEST)

# Host and path used for removing old versions
_WEBHOST=shell1.sourceforge.net
_WEBHTDOCSDIR=/home/groups/s/sd/sdcc/htdocs

_WEBSNAPSHOTDIR=$(WEBHTDOCSDIR)/$(TARBALLBASE)
_WEBREGTESTDIR=$(WEBHTDOCSDIR)/$(REGTESTBASE)
_WEBCHANGELOGDIR=$(WEBHTDOCSDIR)/changelog_heads

# Location to copy the tarball to
_WEBSNAPSHOTDEST=$(_WEBHOST):$(_WEBHTDOCSDIR)

.PHONY: do-upload remove-old-versions
do-upload:
	cd $(STAGINGBASE); \
	rsync -r --include='*.exe' -e ssh --size-only $(HTDOCSDIR)/* $(_WEBSNAPSHOTDEST) && \
	rm -rf $(HTDOCSDIR)/*

# Removes old versions
remove-old-versions:
# over seven days old
#	ssh $(_WEBHOST) 'cd $(_WEBSNAPSHOTDIR); find . -mtime +7 -not -type d -exec rm {} \;'
# more than 7 files in dir
	ssh $(_WEBHOST) 'find $(_WEBSNAPSHOTDIR)/* $(_WEBREGTESTDIR)/* $(_WEBCHANGELOGDIR) -type d -exec sh -c "cd {} ; ls -1t | sed 1,7d | xargs rm -f" \;'
