# gbdk-support (Gameboy Development Kit Support Files) Component

# Prevent multiple inclusion
ifneq ($(GBDKSUPPORTMKINCLUDE), 1)
GBDKSUPPORTMKINCLUDE = 1

# Add gbdk-lib to the list of source trees that need to be fetched
SRCTREES += gbdk-support
# Dir
GBDKSUPPORTDIR = $(SRCDIR)/gbdk-support
# PENDING
GBDKLIBINSTALLDIR = ~/gbdk/
# PENDING
CLEANTARGETS += gbdk-support-clean
# PENDING
CVSREPOSITORIES += cvs.gbdk.sourceforge.net:/cvsroot/gbdk

# Override the default fetch behavoiur
# Default rule for fetching a tree from cvs
$(STAMPDIR)/gbdk-support.fetched: $(ORIGDIR) $(STAMPDIR)
	cd $(ORIGDIR); cvs $(CVSFLAGS) -d:pserver:anonymous@cvs.gbdk.sourceforge.net:/cvsroot/gbdk co gbdk-support
	touch $@

gbdk-support: gbdk-support-lcc

gbdk-support-clean: gbdk-support-lcc-clean

gbdk-support-build-lcc: gbdk-support-lcc-clean
	make -C $(GBDKSUPPORTDIR)/lcc GBDKLIBDIR=$(GBDKLIBINSTALLDIR)

gbdk-support-lcc: gbdk-support-lcc-clean
	make -C $(GBDKSUPPORTDIR)/lcc GBDKLIBDIR=$(GBDKLIBINSTALLDIR)

gbdk-support-install: gbdk-support-lcc
	cp $(GBDKSUPPORTDIR)/lcc/lcc $(BINDIR)

gbdk-support-lcc-clean:
	make -C $(GBDKSUPPORTDIR)/lcc clean

endif
