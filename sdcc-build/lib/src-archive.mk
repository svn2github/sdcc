# Makefile that can archive the source trees for SDCC'S snapshot page
ARCHIVESRCTREES = $(ARCHIVETREES:%=$(STAMPDIR)/%.src-archive)

_ARCHIVE_SRC_TREE_BASENAME = `basename $@ .src-archive`
_ARCHIVE_BASENAME          = $(_ARCHIVE_SRC_TREE_BASENAME).src
_ARCHIVE_DIR               = $(STAGINGBASE)/$(TARBALLBASE)/$(_ARCHIVE_BASENAME)
_ARCHIVE_NAME              = $(_ARCHIVE_BASENAME)-$(HOSTNAME).tar.gz

%.src-archive: %.fetched $(SRCDIR) $(STAMPDIR)
	mkdir -p $(_ARCHIVE_DIR)
	cd $(ORIGDIR); \
	  tar -czf $(_ARCHIVE_DIR)/$(_ARCHIVE_NAME) --exclude=CVS $(_ARCHIVE_SRC_TREE_BASENAME) 
	touch $@

.PHONY: archive-src-trees
archive-src-trees: $(ARCHIVESRCTREES)
