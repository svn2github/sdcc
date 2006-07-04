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

sdcc-extra:
	mkdir -p $(SDCCEXTRADIR)
	cd $(SDCCEXTRADIR); \
	CC=$(TARGETCC) \
	CXX=$(TARGETCXX) \
	STRIP=$(TARGETSTRIP) \
	RANLIB=$(TARGETRANLIB) \
	CPPFLAGS=$(TARGETCPPFLAGS) \
	CXXFLAGS=$(TARGETCXXFLAGS) \
	$(ORIGDIR)/sdcc-extra/configure
	$(MAKE) -C $(SDCCEXTRADIR)

sdcc-extra-clean:
	$(MAKE) -C $(SDCCEXTRADIR) clean

endif
