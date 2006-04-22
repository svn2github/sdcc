# sdcc-extra 'Extra' sdcc related modules used mainly for regression tests.

# Prevent multiple inclusion
ifneq ($(SDCCEXTRAMKINCLUDE), 1)
SDCCEXTRAMKINCLUDE = 1

# Add gbdk-lib to the list of source trees that need to be fetched
SRCTREES += sdcc-extra
# PENDING
SDCCEXTRADIR = $(SRCDIR)/sdcc-extra
# Add sdcc-extra to the list of source trees, that are archieved and copied to the snapshot page
ARCHIVETREES += sdcc-extra

# Override the default fetch behavoiur
# Default rule for fetching a tree from svn
$(STAMPDIR)/sdcc-extra.fetched: $(ORIGDIR) $(STAMPDIR)
	cd $(ORIGDIR); \
	bash -c 'i=0; while ((i < 600)); do { \
	  ((i += 1)); \
	    svn $(SVNFLAGS) --force export https://svn.sourceforge.net/svnroot/sdcc/trunk/sdcc-extra sdcc-extra \
	    && break ; \
	  echo SVN failed $$i: `date`; \
	  sleep 1; \
	} done'
	touch $@

sdcc-extra:
	$(MAKE) -C $(SDCCEXTRADIR)

sdcc-extra-clean:
	$(MAKE) -C $(SDCCEXTRADIR) clean

endif
