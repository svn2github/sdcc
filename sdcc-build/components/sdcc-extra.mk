# sdcc-extra 'Extra' sdcc related modules used mainly for regression tests.

# Prevent multiple inclusion
ifneq ($(SDCCEXTRAMKINCLUDE), 1)
SDCCEXTRAMKINCLUDE = 1

# Add gbdk-lib to the list of source trees that need to be fetched
SRCTREES += sdcc-extra
# PENDING
SDCCEXTRADIR = $(SRCDIR)/sdcc-extra
# PENDING
CVSREPOSITORIES += cvs.sdcc.sourceforge.net:/cvsroot/sdcc

# Override the default fetch behavoiur
# Default rule for fetching a tree from cvs
$(STAMPDIR)/sdcc-extra.fetched: $(ORIGDIR) $(STAMPDIR)
	grep -q :pserver:anonymous@cvs.sdcc.sourceforge.net:/cvsroot/sdcc $HOME/.cvspass || \
	  cvs -d:pserver:anonymous@cvs.sdcc.sourceforge.net:/cvsroot/sdcc login
	cd $(ORIGDIR); cvs $(CVSFLAGS) -d:pserver:anonymous@cvs.sdcc.sourceforge.net:/cvsroot/sdcc co sdcc-extra
	touch $@

sdcc-extra:
	$(MAKE) -C $(SDCCEXTRADIR)

sdcc-extra-clean:
	$(MAKE) -C $(SDCCEXTRADIR) clean

endif
