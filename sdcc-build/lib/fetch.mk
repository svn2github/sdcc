# Makefile that can fetch a copy of the source trees
ORIGSRCTREES = $(SRCTREES:%=$(STAMPDIR)/%.fetched)

fetch-orig-trees: $(ORIGSRCTREES)

update-build-trees: $(SRCDIR) fetch-orig-trees
	for i in $(SRCTREES); do rsync $(RSYNCFLAGS) $(ORIGDIR)/$$i $(SRCDIR); done

# Default rule for fetching a tree from cvs
$(STAMPDIR)/%.fetched: $(ORIGDIR) $(STAMPDIR)
	cd $(ORIGDIR); cvs $(CVSFLAGS) -d:pserver:anonymous@cvs.`basename $@ .fetched`.sourceforge.net:/cvsroot/`basename $@ .fetched` co `basename $@ .fetched`
	touch $@

$(ORIGDIR):
	mkdir -p $(ORIGDIR)

$(SRCDIR):
	mkdir -p $(SRCDIR)

