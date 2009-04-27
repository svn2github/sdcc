include ../packages.mk

PACKAGE=nsis

VERSION=2.44

.PHONY: all
all: $(PACKAGE)-install.tag clean

download/$(PACKAGE)-$(VERSION)-src.tar.bz2:
	wget -P download $(SF_REPOSITORY)/sourceforge/$(PACKAGE)/$(PACKAGE)-$(VERSION)-src.tar.bz2

download/$(PACKAGE)-$(VERSION).zip:
	wget -P download $(SF_REPOSITORY)/sourceforge/$(PACKAGE)/$(PACKAGE)-$(VERSION).zip

$(PACKAGE)-download.tag: download/$(PACKAGE)-$(VERSION)-src.tar.bz2 download/$(PACKAGE)-$(VERSION).zip

$(PACKAGE)-unpack.tag: $(PACKAGE)-download.tag
	tar xjvf download/$(PACKAGE)-*-src.tar.bz2
	touch $@

$(PACKAGE)-configure.tag: $(PACKAGE)-unpack.tag
	cd $(PACKAGE)-$(VERSION)-src && \
	scons PREFIX=$(LOCAL_DIR) SKIPSTUBS=all SKIPPLUGINS=all SKIPUTILS=all SKIPMISC=all VERSION=$(VERSION)
	touch $@

$(PACKAGE)-install.tag: $(PACKAGE)-configure.tag
	install $(PACKAGE)-$(VERSION)-src/build/release/makensis/makensis $(LOCAL_DIR)/bin
	rm -rf $(LOCAL_DIR)/share/$(PACKAGE)
	unzip download/$(PACKAGE)-$(VERSION).zip -d $(LOCAL_DIR)/share
	mv $(LOCAL_DIR)/share/$(PACKAGE)-$(VERSION) $(LOCAL_DIR)/share/$(PACKAGE)
	touch $@

clean:
	rm -rf $(PACKAGE)-$(VERSION)-src download/* *.tag
