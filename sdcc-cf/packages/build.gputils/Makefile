include ../packages.mk

VERSION=$(shell expr download/gputils-*.tar.gz : 'download/gputils-\(.*\).tar.gz')

.PHONY: all
all: gputils-install.tag clean

ifdef FROM_SVN
GPUTILS_DIR=gputils

gputils-download.tag:
	svn --force export https://gputils.svn.sourceforge.net/svnroot/gputils/trunk/gputils gputils
	touch $@

gputils-unpack.tag: gputils-download.tag
	touch $@
else
GPUTILS_DIR=gputils-$(VERSION)

gputils-download.tag:
	wget -P download $(SF_REPOSITORY)/sourceforge/gputils/gputils-0.13.5.tar.gz
	touch $@

gputils-unpack.tag: gputils-download.tag
	tar xzvf download/$(GPUTILS_DIR).tar.gz
	touch $@
endif

gputils-configure.tag: gputils-unpack.tag
	cd $(GPUTILS_DIR) && \
	./configure --prefix=$(LOCAL_DIR)
	touch $@

gputils-make.tag: gputils-configure.tag
	$(MAKE) -C $(GPUTILS_DIR)
	touch $@

gputils-install.tag: gputils-make.tag
	$(MAKE) -C $(GPUTILS_DIR) install
	touch $@

clean:
	rm -rf $(GPUTILS_DIR) download/* *.tag
