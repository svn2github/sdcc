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

sdcc-configured: $(SDCCDIR)/sdccconf.h

$(SDCCDIR)/sdccconf.h:
	cd $(SDCCDIR); CC=$(TARGETCC) CXXFLAGS=$(TARGETCXXFLAGS) ./configure $(SDCCCONFIGUREFLAGS)

sdcc: sdcc-build

sdcc-build: sdcc-configured
	$(MAKE) -C $(SDCCDIR) sdcc-cc sdcc-aslink sdcc-misc sdcc-packihx

# PENDING: Explicit copy of everything in bin
sdcc-install: sdcc-build
	$(MAKE) -C $(SDCCDIR) prefix=$(BUILDDIR) install
	cp $(SDCCDIR)/bin/* $(BUILDDIR)/bin

sdcc-device: sdcc-configured sdcc-build
	$(MAKE) -C $(SDCCDIR) sdcc-device

sdcc-clean:
	echo Here
	$(MAKE) -C $(SDCCDIR) clean

sdcc-device-clean:
