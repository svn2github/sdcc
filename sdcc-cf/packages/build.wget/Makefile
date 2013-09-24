include ../packages.mk

# OOPS, we need some other mathod to bootstrap wget!

PACKAGE=wget
VERSION=1.14
PACKAGE_FILE=$(PACKAGE)-$(VERSION).tar.xz

PACKAGE_DIR=$(PACKAGE)-$(VERSION)

.PHONY: all
all: $(PACKAGE)-install.tag clean

download/$(PACKAGE_FILE):
	wget -P download ftp://mirrors.kernel.org/gnu/$(PACKAGE)/$(PACKAGE_FILE)
	touch $@

$(PACKAGE)-unpack.tag: download/$(PACKAGE_FILE)
	xz -dc download/$(PACKAGE_FILE) | tar xvf -
	touch $@

$(PACKAGE)-configure.tag: $(PACKAGE)-unpack.tag
	cd $(PACKAGE_DIR) && \
	./configure --prefix=$(LOCAL_DIR) --with-ssl
	touch $@

$(PACKAGE)-make.tag: $(PACKAGE)-configure.tag
	$(MAKE) -C $(PACKAGE_DIR)
	touch $@

$(PACKAGE)-install.tag: $(PACKAGE)-make.tag
	$(MAKE) -C $(PACKAGE_DIR) install
	touch $@

clean:
	rm -rf $(PACKAGE_DIR) *.tag
