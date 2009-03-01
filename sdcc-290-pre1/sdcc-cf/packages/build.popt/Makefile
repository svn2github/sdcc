include ../packages.mk

VERSION=$(shell expr download/popt-*.tar.gz : 'download/popt-\(.*\).tar.gz')

.PHONY: all
all: popt-install.tag clean

popt-download.tag:
        wget -P download http://rpm5.org/files/popt/popt-1.14.tar.gz
        touch $@

popt-unpack.tag: popt-download.tag
        tar xzvf download/popt-$(VERSION).tar.gz
        touch $@

popt-configure.tag: popt-unpack.tag
        cd popt-$(VERSION) && \
        ./configure --prefix=$(LOCAL_DIR) CFLAGS="$(CFLAGS)" CXXFLAGS="$(CXXFLAGS)" LDFLAGS="$(LDFLAGS)"
        touch $@

popt-make.tag: popt-configure.tag
        $(MAKE) -C popt-$(VERSION)
        touch $@

popt-install.tag: popt-make.tag
        $(MAKE) -C popt-$(VERSION) install
        touch $@

clean:
        rm -rf popt-$(VERSION) download/* *.tag
