# Makefile that uploades everything from $(HTDOCSDIR) to $(SNAPSHOTDEST)

# Host and path used for removing old versions
WEBHOST=shell1.sourceforge.net
WEBHTDOCSDIR=/home/groups/s/sd/sdcc/htdocs

WEBSNAPSHOTDIR=$(WEBHTDOCSDIR)/$(TARBALLBASE)
WEBREGTESTDIR=$(WEBHTDOCSDIR)/$(REGTESTBASE)

# Location to copy the tarball to
SNAPSHOTDEST=$(WEBHOST):$(WEBHTDOCSDIR)

.PHONY: do-upload remove-old-versions
do-upload:
	cd $(STAGINGBASE); \
	rsync -r --include='*.exe' -e ssh --size-only $(HTDOCSDIR)/* $(SNAPSHOTDEST);
	rm $(HTDOCSDIR)/*/*/*

# Removes old versions
remove-old-versions:
# over seven days old
#	ssh $(WEBHOST) 'cd $(WEBSNAPSHOTDIR); find . -mtime +7 -not -type d -exec rm {} \;'
# more than 7 files in dir
	ssh $(WEBHOST) 'find $(WEBSNAPSHOTDIR)/* $(WEBREGTESTDIR)/* -type d -exec sh -c "cd {} ; ls -1t | sed 1,7d | xargs rm -f" \;'
