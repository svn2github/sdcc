include ../packages.mk

PACKAGE=flex
VERSION=2.5.35
# Wait untill gputils 1.30 with fixed patch "#270 Gputils doesn't compile with newer versions of bison and flex" is released
#VERSION=2.5.37
PACKAGE_FILE=$(PACKAGE)-$(VERSION).tar.bz2

PACKAGE_DIR=$(PACKAGE)-$(VERSION)

all: do-all

download/$(PACKAGE_FILE):
	wget -P download http://sourceforge.net/projects/flex/files/$(PACKAGE_FILE)

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
