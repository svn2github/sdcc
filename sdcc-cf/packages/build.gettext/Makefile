include ../packages.mk

PACKAGE=gettext

VERSION=0.18.1.1

GETTEXT_DIR=$(PACKAGE)-$(VERSION)

.PHONY: all
all: $(PACKAGE)-install.tag clean

download/$(PACKAGE)-$(VERSION).tar.gz:
	wget -nv -P download http://ftp.gnu.org/pub/gnu/$(PACKAGE)/$(PACKAGE)-$(VERSION).tar.gz

$(PACKAGE)-unpack.tag: download/$(PACKAGE)-$(VERSION).tar.gz
	tar xzvf download/$(PACKAGE)-$(VERSION).tar.gz
	touch $@

$(PACKAGE)-configure.tag: $(PACKAGE)-unpack.tag
	cd $(PACKAGE)-$(VERSION) && \
	./configure --prefix=$(LOCAL_DIR) CFLAGS="$(CFLAGS)" CXXFLAGS="$(CXXFLAGS)" LDFLAGS="$(LDFLAGS)"
	touch $@

$(PACKAGE)-make.tag: $(PACKAGE)-configure.tag
	$(MAKE) -C $(GETTEXT_DIR)
	touch $@

$(PACKAGE)-install.tag: $(PACKAGE)-make.tag
	$(MAKE) -C $(GETTEXT_DIR) install  prefix=$(LOCAL_DIR)
	touch $@

.PHONY: clean
clean:
	rm -rf $(GETTEXT_DIR) download/* *.tag
