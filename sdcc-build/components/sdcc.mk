# SDCC Component

# Prevent multiple inclusion
ifneq ($(SDCCMKINCLUDE), 1)
SDCCMKINCLUDE = 1

# Flags to pass on to configure in the sdcc directory
SDCCCONFIGUREFLAGS += 
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

sdcc-configured: $(SDCCDIR)/sdccconf.h

$(SDCCDIR)/sdccconf.h:
	cd $(SDCCDIR); CC=$(TARGETCC) CXXFLAGS=$(TARGETCXXFLAGS) ./configure $(SDCCCONFIGUREFLAGS) > $(NOISELOG)

sdcc: sdcc-build

sdcc-build: sdcc-configured
	$(MAKE) $(MAKEJOBFLAGS) -C $(SDCCDIR) sdcc

# PENDING: sdcc-cc sdcc-aslink sdcc-misc sdcc-packihx

# PENDING: Explicit copy of everything in bin
sdcc-install: sdcc-build
	$(MAKE) -C $(SDCCDIR) prefix=$(BUILDDIR) install
	cp $(SDCCDIR)/bin/* $(BUILDDIR)/bin

sdcc-device: sdcc-configured sdcc-build
	$(MAKE) $(MAKEFLAGS) -C $(SDCCDIR) sdcc-device

sdcc-clean:
	echo Here
	$(MAKE) -C $(SDCCDIR) clean

sdcc-device-clean:

endif
