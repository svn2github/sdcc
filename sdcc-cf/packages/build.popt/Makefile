include ../packages.mk

PACKAGE=popt

VERSION=1.16

.PHONY: all
all: $(PACKAGE)-install.tag clean

download/$(PACKAGE)-$(VERSION).tar.gz:
	wget -P download http://rpm5.org/files/$(PACKAGE)/$(PACKAGE)-$(VERSION).tar.gz

$(PACKAGE)-unpack.tag: download/$(PACKAGE)-$(VERSION).tar.gz
	tar xzvf download/$(PACKAGE)-$(VERSION).tar.gz
	touch $@

$(PACKAGE)-configure.tag: $(PACKAGE)-unpack.tag
	cd $(PACKAGE)-$(VERSION) && \
	./configure --prefix=$(LOCAL_DIR) CFLAGS="$(CFLAGS)" CXXFLAGS="$(CXXFLAGS)" LDFLAGS="$(LDFLAGS)"
	touch $@

$(PACKAGE)-make.tag: $(PACKAGE)-configure.tag
	$(MAKE) -C $(PACKAGE)-$(VERSION)
	touch $@

$(PACKAGE)-install.tag: $(PACKAGE)-make.tag
	$(MAKE) -C $(PACKAGE)-$(VERSION) install
	touch $@

clean:
	rm -rf $(PACKAGE)-$(VERSION) download/* *.tag
