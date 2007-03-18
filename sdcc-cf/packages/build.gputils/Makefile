include ../packages.mk

VERSION=$(shell expr download/gputils-*.tar.gz : 'download/gputils-\(.*\).tar.gz')

.PHONY: all
all: gputils-install.tag clean

gputils-download.tag:
	wget -P download $(SF_REPOSITORY)/sourceforge/gputils/gputils-0.13.4.tar.gz
	touch $@

gputils-unpack.tag: gputils-download.tag
	tar xzvf download/gputils-$(VERSION).tar.gz
	touch $@

gputils-configure.tag: gputils-unpack.tag
	cd gputils-$(VERSION) && \
	./configure --prefix=$(LOCAL_DIR)
	touch $@

gputils-make.tag: gputils-configure.tag
	$(MAKE) -C gputils-$(VERSION)
	touch $@

gputils-install.tag: gputils-make.tag
	$(MAKE) -C gputils-$(VERSION) install
	touch $@

clean:
	rm -rf gputils-$(VERSION) download/* *.tag
