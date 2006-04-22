# Makefile that can fetch a copy of the source trees
ORIGSRCTREES = $(SRCTREES:%=$(STAMPDIR)/%.fetched)
SRCSRCTREES = $(SRCTREES:%=$(STAMPDIR)/%.copied)

# Default rule for fetching a tree from svn
$(STAMPDIR)/%.fetched: $(ORIGDIR) $(STAMPDIR)
	cd $(ORIGDIR); \
	bash -c 'i=0; while ((i < 600)); do { \
	  ((i += 1)); \
	  if [ "$(ISRELEASE)" == "true" ]; \
	  then \
	    svn $(SVNFLAGS) --force export https://svn.sourceforge.net/svnroot/sdcc/tags/$(SVNTAG)/`basename $@ .fetched` `basename $@ .fetched` \
	    && break ; \
          else \
	    svn $(SVNFLAGS) --force export https://svn.sourceforge.net/svnroot/sdcc/trunk/`basename $@ .fetched` `basename $@ .fetched` \
	    && break ; \
	  fi; \
	  echo SVN failed $$i: `date`; \
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
