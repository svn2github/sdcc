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
# PENDING
ifeq ($(CROSSCOMPILING),1)
SDCCBUILDTARGETS = sdcc-cc sdcc-aslink	
else
SDCCBUILDTARGETS = sdcc
endif

sdcc-configured: $(SDCCDIR)/sdccconf.h

$(SDCCDIR)/sdccconf.h:
	-cd $(SDCCDIR); CC=$(TARGETCC) CXX=$(TARGETCXX) STRIP=$(TARGETSTRIP) RANLIB=$(TARGETRANLIB) CXXFLAGS=$(TARGETCXXFLAGS) ./configure $(SDCCCONFIGUREFLAGS) > $(NOISELOG)
	@echo -- Configured sdcc for $(TARGETOS), CC $(TARGETCC)

sdcc: sdcc-build

sdcc-build: sdcc-configured
	$(MAKE) $(MAKEJOBFLAGS) -k -C $(SDCCDIR) $(SDCCBUILDTARGETS)

# PENDING: Explicit copy of everything in bin
# PENDING: Should depend on sdcc-build
sdcc-install:
	$(MAKE) -k -C $(SDCCDIR) prefix=$(BUILDDIR) install
	cp -f $(SDCCDIR)/bin/* $(BUILDDIR)/bin

sdcc-device: sdcc-configured sdcc-build
	$(MAKE) $(MAKEJOBFLAGS) -C $(SDCCDIR) sdcc-device

sdcc-clean:
	echo Here
	$(MAKE) -C $(SDCCDIR) clean

sdcc-device-clean:

endif
