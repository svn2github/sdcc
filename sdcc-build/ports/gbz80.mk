include components/gbdk-lib.mk
include components/gbdk-support.mk

gbz80-port: gbz80-lib gbdk-support

gbz80-lib: gbdk-lib-prep
	PATH=$(PATH):$(BINDIR) $(MAKE) -C $(BUILDDIR)/libc "PLATFORMS=gb rrgb" PORTS=gbz80 SDCCLIB=$(BUILDDIR)

gbz80-port-install: gbz80-port gbdk-support-install
