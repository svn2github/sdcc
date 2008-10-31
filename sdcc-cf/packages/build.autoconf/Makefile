include ../packages.mk

VERSION=$(shell expr download/autoconf-*.tar.bz2 : 'download/autoconf-\(.*\).tar.bz2')

AUTOCONF_DIR=autoconf-$(VERSION)

.PHONY: all
all: autoconf-install.tag clean

autoconf-download.tag:
	wget -P download http://ftp.gnu.org/gnu/autoconf/autoconf-2.63.tar.bz2
	touch $@

autoconf-unpack.tag: autoconf-download.tag
	tar xjvf download/$(AUTOCONF_DIR).tar.bz2
	touch $@

autoconf-configure.tag: autoconf-unpack.tag
	cd $(AUTOCONF_DIR) && \
	./configure --prefix=$(LOCAL_DIR)
	touch $@

autoconf-make.tag: autoconf-configure.tag
	$(MAKE) -C $(AUTOCONF_DIR)
	touch $@

autoconf-install.tag: autoconf-make.tag
	$(MAKE) -C $(AUTOCONF_DIR) install
	touch $@

clean:
	rm -rf $(AUTOCONF_DIR) *.tag
