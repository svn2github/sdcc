include components/gbdk-lib.mk
include components/gbdk-support.mk

HELPTARGETS += z80-help

z80-port: gbdk-lib-prep
	$(MAKE) -C $(BUILDDIR)/libc PLATFORMS=consolez80 PORTS=z80 SDCCLIB=$(BUILDDIR)

z80-help:
	@echo \'make z80-port\' - Build for the z80.


