include ../packages.mk

PACKAGE=bison
VERSION=3.0
PACKAGE_FILE=$(PACKAGE)-$(VERSION).tar.xz

PACKAGE_DIR=$(PACKAGE)-$(VERSION)

all: do-all

download/$(PACKAGE_FILE):
	wget -P download ftp://ftp.gnu.org/gnu/$(PACKAGE)/$(PACKAGE_FILE)

$(PACKAGE)-unpack.tag: unpack-downloaded-package
	touch $@

$(PACKAGE)-configure.tag: $(PACKAGE)-unpack.tag
	cd $(PACKAGE_DIR) && \
	./configure --prefix=$(LOCAL_DIR)
	touch $@

$(PACKAGE)-make.tag: $(PACKAGE)-configure.tag
	$(MAKE) -C $(PACKAGE_DIR)
	touch $@

$(PACKAGE)-install.tag: $(PACKAGE)-make.tag
	$(MAKE) -C $(PACKAGE_DIR) install
	touch $@

include ../common_deps.mk
