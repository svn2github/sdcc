# sdcc-extra 'Extra' sdcc related modules used mainly for regression tests.

# Prevent multiple inclusion
ifneq ($(SDCCEXTRAMKINCLUDE), 1)
SDCCEXTRAMKINCLUDE = 1

# Add gbdk-lib to the list of source trees that need to be fetched
SRCTREES += sdcc-extra
# PENDING
SDCCEXTRADIR = $(SRCDIR)/sdcc-extra
# PENDING
CVSREPOSITORIES += cvs.sourceforge.net:/cvsroot/sdcc
# Add sdcc-extra to the list of source trees, that are archieved and copied to the snapshot page
ARCHIVETREES += sdcc-extra

# CVSACCESS is now set through variables.mk

# Override the default fetch behavoiur
# Default rule for fetching a tree from cvs
$(STAMPDIR)/sdcc-extra.fetched: $(ORIGDIR) $(STAMPDIR)
	# grep -q :pserver:anonymous@cvs.sourceforge.net:/cvsroot/sdcc $(HOME)/.cvspass || \
	#  cvs -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/sdcc login
	cd $(ORIGDIR); \
	sh -c 'i=0; while ((i < 600)); do { \
	  ((i += 1)); \
	    cvs $(CVSFLAGS) -d$(CVSACCESS)@cvs.sourceforge.net:/cvsroot/sdcc co sdcc-extra \
	    && break ; \
	  echo CVS failed $$i: `date`; \
	  sleep 1; \
	} done'
	touch $@

sdcc-extra:
	$(MAKE) -C $(SDCCEXTRADIR)

sdcc-extra-clean:
	$(MAKE) -C $(SDCCEXTRADIR) clean

endif
