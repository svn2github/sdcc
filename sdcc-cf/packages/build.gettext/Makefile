include ../packages.mk

PACKAGE=gettext

VERSION=0.18.1.1

AUTOMAKE_DIR=$(PACKAGE)-$(VERSION)

.PHONY: all
all: $(PACKAGE)-install.tag clean

download/$(PACKAGE)-$(VERSION).tar.gz:
	wget -P download http://ftp.gnu.org/pub/gnu/$(PACKAGE)/$(PACKAGE)-$(VERSION).tar.gz

$(PACKAGE)-unpack.tag: download/$(PACKAGE)-$(VERSION).tar.gz
	tar xzvf download/$(PACKAGE)-$(VERSION).tar.gz
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
