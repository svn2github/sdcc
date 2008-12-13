include ../packages.mk

PACKAGE=libtool

VERSION=$(shell expr download/$(PACKAGE)-*.tar.bz2 : 'download/$(PACKAGE)-\(.*\).tar.bz2')

LIBTOOL_DIR=$(PACKAGE)-$(VERSION)

.PHONY: all
all: $(PACKAGE)-install.tag clean

$(PACKAGE)-download.tag:
	wget -P download http://ftp.gnu.org/gnu/$(PACKAGE)/$(PACKAGE)-2.2.tar.bz2
	touch $@

$(PACKAGE)-unpack.tag: $(PACKAGE)-download.tag
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
	rm -rf $(LIBTOOL_DIR) *.tag
