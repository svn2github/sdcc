# Add maccer to the list of source trees that need to be fetched
SRCTREES += maccer
# PENDING
MACCERDIR = $(SRCDIR)/maccer
# PENDING
CVSREPOSITORIES += cvs.gbdk.sourceforge.net:/cvsroot/gbdk

# Override the default fetch behavoiur
# Default rule for fetching a tree from cvs
$(STAMPDIR)/maccer.fetched: $(ORIGDIR) $(STAMPDIR)
	grep -q :pserver:anonymous@cvs.gbdk.sourceforge.net:/cvsroot/gbdk $(HOME)/.cvspass || \
	  cvs -d:pserver:anonymous@cvs.gbdk.sourceforge.net:/cvsroot/gbdk login
	cd $(ORIGDIR); cvs $(CVSFLAGS) -d:pserver:anonymous@cvs.gbdk.sourceforge.net:/cvsroot/gbdk co maccer
	touch $@

maccer:
	$(MAKE) -C $(MACCERDIR)

maccer-clean:
	$(MAKE) -C $(MACCERDIR) clean

# PENDING
maccer-install:
	cp $(MACCERDIR)/maccer $(BUILDDIR)/bin
