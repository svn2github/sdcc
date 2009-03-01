# sdcc-extra 'Extra' sdcc related modules used mainly for regression tests.

# Prevent multiple inclusion
ifneq ($(SDCCEXTRAMKINCLUDE), 1)
SDCCEXTRAMKINCLUDE = 1

# Add sdcc-extra to the list of source trees that need to be fetched
SRCTREES += sdcc-extra
# PENDING
SDCCEXTRADIR = $(SRCDIR)/sdcc-extra
# Add sdcc-extra to the list of source trees, that are archieved and copied to the snapshot page
ARCHIVETREES += sdcc-extra

sdcc-extra:
# don't build sdcc-extra if cross compiling
ifneq ($(CROSSCOMPILING), 1)
	mkdir -p $(SDCCEXTRADIR)
	cd $(SDCCEXTRADIR); \
	CC=$(TARGETCC) \
	CXX=$(TARGETCXX) \
	STRIP=$(TARGETSTRIP) \
	RANLIB=$(TARGETRANLIB) \
	CPPFLAGS=$(TARGETCPPFLAGS) \
	CFLAGS=$(TARGETCFLAGS) \
	CXXFLAGS=$(TARGETCXXFLAGS) \
	LDFLAGS=$(TARGETLDFLAGS) \
	$(ORIGDIR)/sdcc-extra/configure --host=$(TARGETOS) --build=$(HOSTOS)
	$(MAKE) -C $(SDCCEXTRADIR)
endif

sdcc-extra-clean:
	$(MAKE) -C $(SDCCEXTRADIR) clean

endif
