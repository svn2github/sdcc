include ../packages.mk

VERSION=$(shell expr download/latex2html-*.tar.gz : 'download/latex2html-\(.*\).tar.gz')

.PHONY: all
all: l2h-install.tag clean

l2h-download.tag:
	wget -P download http://fresh.t-systems-sfr.com/unix/src/www/latex2html-2002-2-1.tar.gz
	touch $@

l2h-unpack.tag: l2h-download.tag
	tar xzvf download/latex2html-$(VERSION).tar.gz
	touch $@

l2h-configure.tag: l2h-unpack.tag
	cd latex2html-$(VERSION) && \
	./configure --prefix=$(LOCAL_DIR)
	touch $@

l2h-make.tag: l2h-configure.tag
	$(MAKE) -C latex2html-$(VERSION)
	touch $@

l2h-install.tag: l2h-make.tag
	$(MAKE) -C latex2html-$(VERSION) install
	touch $@

clean:
	rm -rf latex2html-$(VERSION) download/* *.tag
