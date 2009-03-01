include ../packages.mk

ifeq ($(OS), Darwin)
  # Build universal binaries
  CFLAGS = -g -O2 -isysroot /Developer/SDKs/MacOSX10.4u.sdk -arch i386 -arch ppc -DNEED_EXTERN_PC
  CXXFLAGS = -g -O2 -isysroot /Developer/SDKs/MacOSX10.4u.sdk -arch i386 -arch ppc -DNEED_EXTERN_PC
  LDFLAGS = -g -O2 -arch i386 -arch ppc
  CONFFLAGS = --disable-dependency-tracking
endif

VERSION=$(shell expr download/readline-*.tar.gz : 'download/readline-\(.*\).tar.gz')

.PHONY: all
all: readline-install.tag #clean

readline-download.tag:
	wget -P download ftp://ftp.cwru.edu/pub/bash/readline-5.2.tar.gz
	touch $@

readline-unpack.tag: readline-download.tag
	tar xzvf download/readline-$(VERSION).tar.gz
	touch $@

readline-configure.tag: readline-unpack.tag
	cd readline-$(VERSION) && \
	./configure --prefix=$(LOCAL_DIR) $(CONFFLAGS) CFLAGS="$(CFLAGS)" CXXFLAGS="$(CXXFLAGS)" LDFLAGS="$(LDFLAGS)"
	touch $@

readline-make.tag: readline-configure.tag
	$(MAKE) -C readline-$(VERSION)
	touch $@

readline-install.tag: readline-make.tag
	$(MAKE) -C readline-$(VERSION) install
	touch $@

clean:
	rm -rf readline-$(VERSION) download/* *.tag
