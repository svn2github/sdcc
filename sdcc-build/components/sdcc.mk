# SDCC Component

# Prevent multiple inclusion
ifneq ($(SDCCMKINCLUDE), 1)
SDCCMKINCLUDE = 1

# Flags to pass on to configure in the sdcc directory:
SDCCCONFIGUREFLAGS += --disable-werror
# Add sdcc to the list of source trees that need to be fetched
SRCTREES += sdcc
# PENDING
CLEANTARGETS += sdcc-clean sdcc-device-clean
# PENDING
INSTALLTARGETS += sdcc-install
# Add sdcc to the list of source trees, that are archieved and copied to the snapshot page
ARCHIVETREES += sdcc

# Directory that the copy of sdcc is located in
_SDCCDIR = $(SRCDIR)/sdcc

sdcc-configured: $(_SDCCDIR)/sdccconf.h

$(_SDCCDIR)/sdccconf.h:
	mkdir -p $(_SDCCDIR)
	cd $(_SDCCDIR); \
	CC=$(TARGETCC) \
	CXX=$(TARGETCXX) \
	AR=$(TARGETAR) \
	RANLIB=$(TARGETRANLIB) \
	STRIP=$(TARGETSTRIP) \
	CPPFLAGS=$(TARGETCPPFLAGS) \
	CFLAGS=$(TARGETCFLAGS) \
	CXXFLAGS=$(TARGETCXXFLAGS) \
	LDFLAGS=$(TARGETLDFLAGS) \
	$(ORIGDIR)/sdcc/configure $(SDCCCONFIGUREFLAGS) --host=$(TARGETOS) --build=$(HOSTOS)
	@echo -- Configured sdcc for $(TARGETOS), CC=$(TARGETCC), CXX=$(TARGETCXX)

sdcc: sdcc-build

sdcc-build: sdcc-configured
	$(MAKE) $(MAKEJOBFLAGS) $(MAKESILENTFLAG) -k -C $(_SDCCDIR) sdcc

# PENDING: Should depend on sdcc-build
sdcc-install: sdcc-targetos-install sdcc-fromhost-install sdcc-docs

sdcc-targetos-install:
	$(MAKE) $(MAKESILENTFLAG) -k -C $(_SDCCDIR) DESTDIR=$(BUILDDIR) STRIP=$(TARGETSTRIP) $(SDCCINSTALLFLAGS) install

# Copies files from the native host that couldn't be compiled.
sdcc-fromhost-install:
ifeq ($(CROSSCOMPILING), 1)
	cd $(TOPDIR)/build/$(HOSTOS)/sdcc$(HOSTPREFIX)/share/sdcc; cp -r * $(BUILDDIR)$(PREFIX)
endif

# There are no docs in the snapshot
sdcc-docs:
ifeq ($(ISRELEASE),true)
	echo Fetch sdcc.doc.tar.gz and add it to the archive!
else
	mkdir -p $(CHLOGDIR)
ifneq ($(CROSSCOMPILING), 1)
	rm -rf $(BUILDDIR)$(PREFIX)/share/sdcc/doc/*
	mkdir -p $(BUILDDIR)$(PREFIX)/share/sdcc/doc
	cp -p $(TOPDIR)/support/readme-snapshot.txt $(BUILDDIR)$(PREFIX)/share/sdcc/doc/README
	head -n 100 $(ORIGDIR)/sdcc/ChangeLog > $(BUILDDIR)$(PREFIX)/share/sdcc/doc/ChangeLog.head
	cp $(BUILDDIR)$(PREFIX)/share/sdcc/doc/ChangeLog.head $(CHLOGTXT)
else
	rm -rf $(BUILDDIR)/sdcc/doc/*
	mkdir -p $(BUILDDIR)/sdcc/doc
	cp -p $(TOPDIR)/support/readme-snapshot.txt $(BUILDDIR)/sdcc/doc/README.TXT
	head -n 100 $(ORIGDIR)/sdcc/ChangeLog > $(BUILDDIR)/sdcc/doc/ChangeLog_head.txt
	cp $(BUILDDIR)/sdcc/doc/ChangeLog_head.txt $(CHLOGTXT)
endif
endif

sdcc-device: sdcc-configured sdcc-build
	$(MAKE) $(MAKEJOBFLAGS) -C $(_SDCCDIR) sdcc-device

sdcc-clean:
	$(MAKE) -C $(_SDCCDIR) clean

sdcc-install-clean:
	rm -rf $(BUILDDIR)

sdcc-device-clean:

ifdef CC_FOR_BUILD
CC_FOR_BUILD_STR = CC_FOR_BUILD=$(CC_FOR_BUILD)
endif

ifeq ($(CROSSCOMPILING), 1)
ifeq ($(TARGETOS), x86_64-w64-mingw32)
  WINE = wine64
else
  WINE = wine
endif
endif

sdcc-regression: sdcc sdcc-install sdcc-extra
	echo "--- Regression testing started on `date` ---"
ifeq ($(CROSSCOMPILING), 1)
	# mingw cross regression testing with wine
	# uninstall the previous version
	-wine sdcc --version > /dev/null 2>&1 && wine 'c:/Program Files/SDCC/uninstall' /S && sleep 10
	# install sdcc package
	-wine $(SETUPNAME) /S && sleep 10
	# perform regression tests
	if $(WINE) sdcc --version > /dev/null 2>&1; \
	then \
	  mkdir -p $(REGTESTDIR); \
	  rm -rf $(_SDCCDIR)/support/regression/gen $(_SDCCDIR)/support/regression/results; \
	  WINEDEBUG=fixme-all $(MAKE) $(MAKESILENTFLAG) -C $(_SDCCDIR)/support/regression SDCC_HOME=$(BUILDDIR) SDCC_EXTRA_DIR=$(SRCDIR)/sdcc-extra $(CROSSREGTESTTARGETS) CROSSCOMPILING=$(CROSSCOMPILING) SDCC="$(WINE) sdcc" WINE=$(WINE) $(CC_FOR_BUILD_STR) 2>&1 | tee $(REGTESTLOG); \
	fi
else
	# perform regression tests
	mkdir -p $(REGTESTDIR); \
	$(MAKE) $(MAKESILENTFLAG) -C $(_SDCCDIR)/support/regression SDCC_HOME=$(BUILDDIR) SDCC_EXTRA_DIR=$(SRCDIR)/sdcc-extra $(REGTESTTARGETS) 2>&1 | tee $(REGTESTLOG)
endif
	echo "--- Regression testing finished on `date` ---"

endif
