# SDCC Component

# Prevent multiple inclusion
ifneq ($(SDCCMKINCLUDE), 1)
SDCCMKINCLUDE = 1

# Flags to pass on to configure in the sdcc directory
SDCCCONFIGUREFLAGS += --program-suffix=$(EXEEXTENSION)
# Directory that the copy of sdcc is located in
SDCCDIR = $(SRCDIR)/sdcc
# Add sdcc to the list of source trees that need to be fetched
SRCTREES += sdcc
# PENDING
CLEANTARGETS += sdcc-clean sdcc-device-clean
# PENDING
INSTALLTARGETS += sdcc-install
# PENDING
CVSREPOSITORIES += cvs.sdcc.sourceforge.net:/cvsroot/sdcc
# Add sdcc to the list of source trees, that are archieved and copied to the snapshot page
ARCHIVETREES += sdcc

sdcc-configured: $(SDCCDIR)/sdccconf.h

$(SDCCDIR)/sdccconf.h:
	cd $(SDCCDIR); CC=$(TARGETCC) CXX=$(TARGETCXX) STRIP=$(TARGETSTRIP) RANLIB=$(TARGETRANLIB) CXXFLAGS=$(TARGETCXXFLAGS) ./configure $(SDCCCONFIGUREFLAGS) --host=$(TARGETOS) --target=$(TARGETOS) --build=$(HOSTOS) > $(NOISELOG)
	@echo -- Configured sdcc for $(TARGETOS), CC $(TARGETCC)

sdcc: sdcc-build

sdcc-build: sdcc-configured
	$(MAKE) $(MAKEJOBFLAGS) -k -C $(SDCCDIR) sdcc

# PENDING: Should depend on sdcc-build
sdcc-install: sdcc-targetos-install sdcc-fromhost-install sdcc-docs

sdcc-targetos-install:
	$(MAKE) -k -C $(SDCCDIR) prefix=$(BUILDDIR) install

# Copies files from the native host that couldn't be compiled.
sdcc-fromhost-install:
ifeq ($(CROSSCOMPILING), 1)
	cd $(TOPDIR)/build/$(HOSTOS)/sdcc; cp -r share $(BUILDDIR)
endif

# There are no docs in the snapshot
sdcc-docs:
ifeq ($(ISRELEASE),true)
	echo Fetch sdcc.doc.tar.gz and add it to the archive!
else
ifneq ($(CROSSCOMPILING), 1)
	rm -rf $(BUILDDIR)/share/sdcc/doc/*
	cp -p $(TOPDIR)/support/readme-snapshot.txt $(BUILDDIR)/share/sdcc/doc/README
	head -n 100 $(SDCCDIR)/ChangeLog > $(BUILDDIR)/share/sdcc/doc/ChangeLog.head
else
# some day /share will be omitted for windoze
	rm -rf $(BUILDDIR)/share/sdcc/doc/*
	cp -p $(TOPDIR)/support/readme-snapshot.txt $(BUILDDIR)/share/sdcc/doc/README.TXT
	head -n 100 $(SDCCDIR)/ChangeLog > $(BUILDDIR)/share/sdcc/doc/ChangeLog_head.txt
endif
endif

sdcc-device: sdcc-configured sdcc-build
	$(MAKE) $(MAKEJOBFLAGS) -C $(SDCCDIR) sdcc-device

sdcc-clean:
#	echo Here
	$(MAKE) -C $(SDCCDIR) clean

sdcc-device-clean:

sdcc-regression: sdcc sdcc-install sdcc-extra
# test-gbz80 temporary disabled because of problems; Bernhard 2003-02-13
ifneq ($(CROSSCOMPILING), 1)
	$(MAKE) -C src/sdcc/support/regression SDCC_DIR=$(BUILDDIR) SDCC_EXTRA_DIR=$(TOPDIR)/src/sdcc-extra test-host test-z80 test-mcs51 test-mcs51-stack-auto test-mcs51-large test-ds390
endif

endif
