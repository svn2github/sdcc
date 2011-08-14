include ../packages.mk

PACKAGE=libtool

VERSION=2.2

LIBTOOL_DIR=$(PACKAGE)-$(VERSION)

.PHONY: all
all: $(PACKAGE)-install.tag clean

download/$(PACKAGE)-$(VERSION).tar.bz2:
	wget -P download http://ftp.gnu.org/gnu/$(PACKAGE)/$(PACKAGE)-$(VERSION).tar.bz2

$(PACKAGE)-unpack.tag: download/$(PACKAGE)-$(VERSION).tar.bz2
	tar xjvf download/$(LIBTOOL_DIR).tar.bz2
	touch $@

$(PACKAGE)-configure.tag: $(PACKAGE)-unpack.tag
	cd $(LIBTOOL_DIR) && \
	./configure --prefix=$(LOCAL_DIR)
	touch $@

$(PACKAGE)-make.tag: $(PACKAGE)-configure.tag
	$(MAKE) -C $(LIBTOOL_DIR)
	touch $@

$(PACKAGE)-install.tag: $(PACKAGE)-make.tag
	$(MAKE) -C $(LIBTOOL_DIR) install
	touch $@

clean:
	rm -rf $(LIBTOOL_DIR) download/* *.tag
