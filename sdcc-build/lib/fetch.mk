# Makefile that can fetch a copy of the source trees
ORIGSRCTREES = $(SRCTREES:%=$(STAMPDIR)/%.fetched)
SRCSRCTREES = $(SRCTREES:%=$(STAMPDIR)/%.copied)

# Default rule for fetching a tree from cvs
$(STAMPDIR)/%.fetched: $(ORIGDIR) $(STAMPDIR)
	cd $(ORIGDIR); cvs $(CVSFLAGS) -d:pserver:anonymous@cvs.`basename $@ .fetched`.sourceforge.net:/cvsroot/`basename $@ .fetched` co `basename $@ .fetched`
	touch $@

%.copied: %.fetched $(SRCDIR) $(STAMPDIR) 
	rsync $(RSYNCFLAGS) $(ORIGDIR)/`basename $@ .copied` $(SRCDIR)
	touch $@

fetch-orig-trees: $(ORIGSRCTREES)

fetch-build-trees: $(SRCSRCTREES)

# Couldn't automate the password
fetch-login-all:
	for i in $(CVSREPOSITORIES); do cvs -d:pserver:anonymous@$$i login; done
