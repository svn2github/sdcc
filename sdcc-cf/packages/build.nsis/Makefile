include ../packages.mk

PACKAGE=nsis

VERSION=$(shell expr download/$(PACKAGE)-*-src.tar.bz2 : 'download/$(PACKAGE)-\(.*\)-src.tar.bz2')

.PHONY: all
all: $(PACKAGE)-install.tag clean

$(PACKAGE)-download.tag:
	wget -P download $(SF_REPOSITORY)/sourceforge/$(PACKAGE)/$(PACKAGE)-2.42-src.tar.bz2
	wget -P download $(SF_REPOSITORY)/sourceforge/$(PACKAGE)/$(PACKAGE)-2.42.zip
	touch $@

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
