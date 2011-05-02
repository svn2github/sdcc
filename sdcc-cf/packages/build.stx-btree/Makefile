include ../packages.mk

PACKAGE=stx-btree
VERSION=0.8.3
PACKAGE_FILE=$(PACKAGE)-$(VERSION).tar.bz2

PACKAGE_DIR=$(PACKAGE)-$(VERSION)

.PHONY: all
all: $(PACKAGE)-install.tag clean

download/$(PACKAGE_FILE):
	wget -P download http://idlebox.net/2007/$(PACKAGE)/$(PACKAGE_FILE)

$(PACKAGE)-download.tag: download/$(PACKAGE_FILE)
	touch $@

$(PACKAGE)-unpack.tag: $(PACKAGE)-download.tag
	tar xjvf download/$(PACKAGE_FILE)
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

clean:
	rm -rf $(PACKAGE_DIR) *.tag
