###############################################################################
# To build gputils from the svn HEAD:
# make FROM_SVN=1

include ../packages.mk

PACKAGE=gputils
VERSION=1.2.0
PACKAGE_FILE=$(PACKAGE)-$(VERSION).tar.gz

all: do-all

ifdef FROM_SVN
PACKAGE_DIR=$(PACKAGE)

$(PACKAGE)-unpack.tag:
	svn --force export svn://svn.code.sf.net/p/gputils/code/trunk/gputils gputils
	touch $@
else
PACKAGE_DIR=$(PACKAGE)-$(VERSION)

download/$(PACKAGE_FILE):
	wget -P download http://sourceforge.net/projects/$(PACKAGE)/files/$(PACKAGE_FILE)

$(PACKAGE)-unpack.tag: unpack-downloaded-package
	touch $@
endif

$(PACKAGE)-configure.tag: $(PACKAGE)-unpack.tag
	cd $(PACKAGE_DIR) && \
	./configure --prefix=$(LOCAL_DIR) --disable-html-doc
	touch $@

$(PACKAGE)-make.tag: $(PACKAGE)-configure.tag
	$(MAKE) -C $(PACKAGE_DIR)
	touch $@

$(PACKAGE)-install.tag: $(PACKAGE)-make.tag
	$(MAKE) -C $(PACKAGE_DIR) install
	touch $@

include ../common_deps.mk
