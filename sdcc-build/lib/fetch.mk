# Makefile that can fetch a copy of the source trees
ORIGSRCTREES = $(SRCTREES:%=$(STAMPDIR)/%.fetched)
SRCSRCTREES = $(SRCTREES:%=$(STAMPDIR)/%.copied)

# Default rule for fetching a tree from cvs
#$(STAMPDIR)/%.fetched: $(ORIGDIR) $(STAMPDIR)
#	cd $(ORIGDIR); cvs $(CVSFLAGS) -d:pserver:anonymous@cvs.`basename $@ .fetched`.sourceforge.net:/cvsroot/`basename $@ .fetched` co `basename $@ .fetched`
#	touch $@

$(STAMPDIR)/%.copied: $(STAMPDIR)/%.fetched $(SRCDIR) $(STAMPDIR) 
	rsync $(RSYNCFLAGS) $(ORIGDIR)/`basename $@ .copied` $(SRCDIR)
	touch $@

fetch-orig-trees: $(ORIGSRCTREES)

fetch-build-trees: fetch-orig-trees $(SRCSRCTREES)
