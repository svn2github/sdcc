include ../packages.mk

VERSION=$(shell expr download/nsis-*-src.tar.bz2 : 'download/nsis-\(.*\)-src.tar.bz2')

.PHONY: all
all: nsis-install.tag clean

nsis-download.tag:
	wget -P download $(SF_REPOSITORY)/sourceforge/nsis/nsis-2.27-src.tar.bz2
	wget -P download $(SF_REPOSITORY)/sourceforge/nsis/nsis-2.27.zip
	touch $@

nsis-unpack.tag: nsis-download.tag
	tar xjvf download/nsis-*-src.tar.bz2
	touch $@

nsis-configure.tag: nsis-unpack.tag
	cd nsis-$(VERSION)-src && \
	scons PREFIX=$(LOCAL_DIR) SKIPSTUBS=all SKIPPLUGINS=all SKIPUTILS=all SKIPMISC=all VERSION=$(VERSION)
	touch $@

nsis-install.tag: nsis-configure.tag
	install nsis-$(VERSION)-src/build/release/makensis/makensis $(LOCAL_DIR)/bin
	rm -rf $(LOCAL_DIR)/share/nsis
	unzip download/nsis-$(VERSION).zip -d $(LOCAL_DIR)/share
	mv $(LOCAL_DIR)/share/nsis-$(VERSION) $(LOCAL_DIR)/share/nsis
	touch $@

clean:
	rm -rf nsis-$(VERSION)-src download/* *.tag
