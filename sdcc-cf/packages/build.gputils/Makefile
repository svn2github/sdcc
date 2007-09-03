include ../packages.mk

VERSION=$(shell expr download/gputils-*.tar.gz : 'download/gputils-\(.*\).tar.gz')

#GPUTILS_DIR=gputils-$(VERSION)
GPUTILS_DIR=gputils

.PHONY: all
all: gputils-install.tag clean

#gputils-download.tag:
#	wget -P download $(SF_REPOSITORY)/sourceforge/gputils/gputils-0.13.4.tar.gz
#	touch $@
#
#gputils-unpack.tag: gputils-download.tag
#	tar xzvf download/$(GPUTILS_DIR).tar.gz
#	touch $@

gputils-download.tag:
	cvs -z3 -d:pserver:anonymous@gputils.cvs.sourceforge.net:/cvsroot/gputils co gputils
	touch $@

gputils-unpack.tag: gputils-download.tag
	touch $@

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
