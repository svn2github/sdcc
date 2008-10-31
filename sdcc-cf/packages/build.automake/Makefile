include ../packages.mk

VERSION=$(shell expr download/automake-*.tar.bz2 : 'download/automake-\(.*\).tar.bz2')

AUTOMAKE_DIR=automake-$(VERSION)

.PHONY: all
all: automake-install.tag clean

automake-download.tag:
	wget -P download http://ftp.gnu.org/gnu/automake/automake-1.10.tar.bz2
	touch $@

automake-unpack.tag: automake-download.tag
	tar xjvf download/$(AUTOMAKE_DIR).tar.bz2
	touch $@

automake-configure.tag: automake-unpack.tag
	cd $(AUTOMAKE_DIR) && \
	./configure --prefix=$(LOCAL_DIR)
	touch $@

automake-make.tag: automake-configure.tag
	$(MAKE) -C $(AUTOMAKE_DIR)
	touch $@

automake-install.tag: automake-make.tag
	$(MAKE) -C $(AUTOMAKE_DIR) install
	touch $@

clean:
	rm -rf $(AUTOMAKE_DIR) *.tag
