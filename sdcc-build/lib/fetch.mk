# Makefile that can fetch a copy of the source trees
ORIGSRCTREES = $(SRCTREES:%=$(STAMPDIR)/%.fetched)
SRCSRCTREES = $(SRCTREES:%=$(STAMPDIR)/%.copied)

# Default rule for fetching a tree from cvs
$(STAMPDIR)/%.fetched: $(ORIGDIR) $(STAMPDIR)
	grep -q pserver:anonymous@cvs.`basename $@ .fetched`.sourceforge.net:/cvsroot/`basename $@ .fetched` $(HOME)/.cvspass || \
	 cvs -d:pserver:anonymous@cvs.`basename $@ .fetched`.sourceforge.net:/cvsroot/`basename $@ .fetched` login
	cd $(ORIGDIR); \
	sh -c 'i=0; while ((i < 600)); do { \
	  ((i += 1)); \
	  cvs $(CVSFLAGS) -d:pserver:anonymous@cvs.`basename $@ .fetched`.sourceforge.net:/cvsroot/`basename $@ .fetched` co $(CVSTAGFLAG) `basename $@ .fetched` \
	    && break ; \
	  echo CVS failed $$i: `date`; \
	  sleep 1; \
	} done'
	touch $@

%.copied: %.fetched $(SRCDIR) $(STAMPDIR) 
	rsync $(RSYNCFLAGS) $(ORIGDIR)/`basename $@ .copied` $(SRCDIR)
	touch $@

fetch-orig-trees: $(ORIGSRCTREES)

fetch-build-trees: $(SRCSRCTREES)

# Couldn't automate the password
fetch-login-all:
	for i in $(CVSREPOSITORIES); do cvs -d:pserver:anonymous@$$i login; done
