include ../packages.mk

PACKAGE=flex
VERSION=2.5.37
PACKAGE_FILE=$(PACKAGE)-$(VERSION).tar.bz2

PACKAGE_DIR=$(PACKAGE)-$(VERSION)

.PHONY: all
all: $(PACKAGE)-install.tag clean

download/$(PACKAGE_FILE):
	wget -P download http://sourceforge.net/projects/flex/files/$(PACKAGE)/$(PACKAGE)-$(VERSION)/$(PACKAGE_FILE)

$(PACKAGE)-unpack.tag: download/$(PACKAGE_FILE)
	tar xjvf download/$(PACKAGE_FILE)
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

clean:
	rm -rf $(PACKAGE_DIR) *.tag
