# Makefile that can archive the source trees and copy the archive to the snapshot page
ARCHIVESRCTREES = $(ARCHIVETREES:%=$(STAMPDIR)/%.src-archive)

%.src-archive: %.fetched $(SRCDIR) $(STAMPDIR)
	mkdir -p $(STAGINGBASE)/$(TARBALLBASE)/`basename $@ .src-archive`.src
	cd $(ORIGDIR)/`basename $@ .src-archive`; tar -czf $(STAGINGBASE)/$(TARBALLBASE)/`basename $@ .src-archive`.src/`basename $@ .src-archive`.tar.gz --exclude=CVS *
	touch $@

.PHONY: archive-src-trees
archive-src-trees: $(ARCHIVESRCTREES)
