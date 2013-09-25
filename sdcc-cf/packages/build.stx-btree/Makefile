###############################################################################
# To install it for mingw cross-compilation:
# make LOCAL_DIR=~/local-cf-x86/cross-tools/i586-mingw32msvc

include ../packages.mk

PACKAGE=stx-btree
VERSION=0.9
PACKAGE_FILE=$(PACKAGE)-$(VERSION).tar.bz2

PACKAGE_DIR=$(PACKAGE)-$(VERSION)

all: do-all

download/$(PACKAGE_FILE):
	wget -P download http://panthema.net/2007/$(PACKAGE)/$(PACKAGE_FILE)

$(PACKAGE)-unpack.tag: unpack-downloaded-package
	touch $@

$(PACKAGE)-configure.tag: $(PACKAGE)-unpack.tag
	cd $(PACKAGE_DIR) && \
	./configure --prefix=$(LOCAL_DIR)
	touch $@

$(PACKAGE)-make.tag: $(PACKAGE)-configure.tag
	touch $@

$(PACKAGE)-install.tag: $(PACKAGE)-make.tag
	cd $(PACKAGE_DIR)/include && \
	make install
	touch $@

include../common_deps.mk
