include ../packages.mk

PACKAGE=wine

VERSION=1.2.3

AUTOMAKE_DIR=$(PACKAGE)-$(VERSION)

.PHONY: all
all: $(PACKAGE)-install.tag clean

download/$(PACKAGE)-$(VERSION).tar.bz2:
	wget -P download http://sourceforge.net/projects/wine/files/Source/$(PACKAGE)-$(VERSION).tar.bz2

$(PACKAGE)-unpack.tag: download/$(PACKAGE)-$(VERSION).tar.bz2
	tar xjvf download/$(PACKAGE)-$(VERSION).tar.bz2
	touch $@

$(PACKAGE)-configure.tag: $(PACKAGE)-unpack.tag
	cd $(PACKAGE)-$(VERSION) && \
	./configure --prefix=$(LOCAL_DIR) CFLAGS="$(CFLAGS)" CXXFLAGS="$(CXXFLAGS)" LDFLAGS="$(LDFLAGS)"
	touch $@

$(PACKAGE)-make.tag: $(PACKAGE)-configure.tag
	$(MAKE) -C $(AUTOMAKE_DIR)
	touch $@

$(PACKAGE)-install.tag: $(PACKAGE)-make.tag
	$(MAKE) -C $(AUTOMAKE_DIR) install  prefix=$(LOCAL_DIR)
	touch $@

clean:
	rm -rf $(AUTOMAKE_DIR) download/* *.tag
