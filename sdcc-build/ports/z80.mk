include components/gbdk-lib.mk
include components/gbdk-support.mk

z80-port: gbdk-lib-prep
	$(MAKE) -C $(BUILDDIR)/libc PLATFORMS=consolez80 PORTS=z80 SDCCLIB=$(BUILDDIR)

