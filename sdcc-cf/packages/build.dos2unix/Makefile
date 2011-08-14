include ../packages.mk

PACKAGE=dos2unix

VERSION=5.3.1

AUTOMAKE_DIR=$(PACKAGE)-$(VERSION)

.PHONY: all
all: $(PACKAGE)-install.tag clean

download/$(PACKAGE)-$(VERSION).tar.gz:
	wget -P download http://sourceforge.net/projects/$(PACKAGE)/files/$(PACKAGE)/$(VERSION)/$(PACKAGE)-$(VERSION).tar.gz

$(PACKAGE)-unpack.tag: download/$(PACKAGE)-$(VERSION).tar.gz
	tar xzvf download/$(PACKAGE)-$(VERSION).tar.gz
	touch $@

$(PACKAGE)-make.tag: $(PACKAGE)-unpack.tag
	$(MAKE) -C $(AUTOMAKE_DIR)
	touch $@

$(PACKAGE)-install.tag: $(PACKAGE)-make.tag
	$(MAKE) -C $(AUTOMAKE_DIR) install  prefix=$(LOCAL_DIR)
	touch $@

clean:
	rm -rf $(AUTOMAKE_DIR) download/* *.tag
