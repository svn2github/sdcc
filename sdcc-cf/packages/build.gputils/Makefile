###############################################################################
# To build gputils from the svn HEAD:
# make FROM_SVN=1

include ../packages.mk

PACKAGE=gputils
VERSION=0.14.2
PACKAGE_FILE=$(PACKAGE)-$(VERSION).tar.gz

.PHONY: all
all: $(PACKAGE)-install.tag clean

ifdef FROM_SVN
GPUTILS_DIR=$(PACKAGE)

$(PACKAGE)-download.tag:
	svn --force export svn://svn.code.sf.net/p/gputils/code/trunk/gputils gputils
	touch $@

$(PACKAGE)-unpack.tag: $(PACKAGE)-download.tag
	touch $@
else
GPUTILS_DIR=$(PACKAGE)-$(VERSION)

download/$(PACKAGE_FILE):
	wget -P download $(SF_REPOSITORY)/sourceforge/gputils/$(PACKAGE_FILE)

$(PACKAGE)-download.tag: download/$(PACKAGE_FILE)
	touch $@

$(PACKAGE)-unpack.tag: $(PACKAGE)-download.tag
	tar xzvf download/$(PACKAGE_FILE)
	touch $@
endif

$(PACKAGE)-configure.tag: $(PACKAGE)-unpack.tag
	cd $(GPUTILS_DIR) && \
	./configure --prefix=$(LOCAL_DIR) --disable-html-doc
	touch $@

$(PACKAGE)-make.tag: $(PACKAGE)-configure.tag
	$(MAKE) -C $(GPUTILS_DIR)
	touch $@

$(PACKAGE)-install.tag: $(PACKAGE)-make.tag
	$(MAKE) -C $(GPUTILS_DIR) install
	touch $@

clean:
	rm -rf $(GPUTILS_DIR) download/* *.tag
