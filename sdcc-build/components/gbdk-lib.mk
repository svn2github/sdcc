# gbdk-lib (Gameboy Development Kit Libraries) Component

# Prevent multiple inclusion
ifneq ($(GBDKLIBMKINCLUDE), 1)
GBDKLIBMKINCLUDE = 1

# Add gbdk-lib to the list of source trees that need to be fetched
SRCTREES += gbdk-lib
# PENDING
GBDKLIBDIR = $(SRCDIR)/gbdk-lib
# PENDING
CVSREPOSITORIES += cvs.gbdk.sourceforge.net:/cvsroot/gbdk

include components/maccer.mk

# Override the default fetch behavoiur
# Default rule for fetching a tree from cvs
$(STAMPDIR)/gbdk-lib.fetched: $(ORIGDIR) $(STAMPDIR)
	grep -q :pserver:anonymous@cvs.gbdk.sourceforge.net:/cvsroot/gbdk $(HOME)/.cvspass || \
	  cvs -d:pserver:anonymous@cvs.gbdk.sourceforge.net:/cvsroot/gbdk login
	cd $(ORIGDIR); cvs $(CVSFLAGS) -d:pserver:anonymous@cvs.gbdk.sourceforge.net:/cvsroot/gbdk co gbdk-lib
	touch $@

gbdk-lib-prep: sdcc sdcc-install gbdk-support-build-lcc gbdk-lib-copy maccer maccer-install

gbdk-lib-copy: $(BUILDDIR)/Makefile.common

$(BUILDDIR)/Makefile.common:
	cp -r $(GBDKLIBDIR)/examples $(GBDKLIBDIR)/libc $(GBDKLIBDIR)/tools $(GBDKLIBDIR)/include $(GBDKLIBDIR)/Makefile.common $(BUILDDIR)

endif
