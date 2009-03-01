# Makefile that can archive the source trees for SDCC'S snapshot page
ARCHIVESRCTREES = $(ARCHIVETREES:%=%-src-archive)

_ARCHIVE_SRC_TREE_BASENAME = $(shell basename $@ -src-archive)
_ARCHIVE_BASENAME          = $(_ARCHIVE_SRC_TREE_BASENAME)-src
_ARCHIVE_DIR               = $(HTDOCSDIR)/$(TARBALLBASE)/$(_ARCHIVE_BASENAME)
_ARCHIVE_NAME              = $(_ARCHIVE_BASENAME)-$(SNAPSHOTID).tar.bz2

%-src-archive: fetch-orig-trees
	mkdir -p $(_ARCHIVE_DIR)
	cd $(ORIGDIR); \
	  tar -cjf $(_ARCHIVE_DIR)/$(_ARCHIVE_NAME) --exclude=CVS --exclude=.svn $(_ARCHIVE_SRC_TREE_BASENAME)

.PHONY: archive-src-trees
archive-src-trees: $(ARCHIVESRCTREES)
