include ../packages.mk

VERSION=$(shell expr download/wget-*.tar.gz : 'download/wget-\(.*\).tar.gz')

WGET_DIR=wget-$(VERSION)

.PHONY: all
all: wget-install.tag clean

wget-download.tag:
	wget -P download ftp://mirrors.kernel.org/gnu/wget/wget-1.10.2.tar.gz
	touch $@

wget-unpack.tag: wget-download.tag
	tar xzvf download/$(WGET_DIR).tar.gz
	touch $@

wget-configure.tag: wget-unpack.tag
	cd $(WGET_DIR) && \
	./configure --prefix=$(LOCAL_DIR) --with-ssl
	touch $@

wget-make.tag: wget-configure.tag
	$(MAKE) -C $(WGET_DIR)
	touch $@

wget-install.tag: wget-make.tag
	$(MAKE) -C $(WGET_DIR) install
	touch $@

clean:
	rm -rf $(WGET_DIR) *.tag
