include ../packages.mk

ifeq ($(OS), Darwin)
  # Build universl binaries
  CFLAGS += -isysroot /Developer/SDKs/MacOSX10.4u.sdk -arch i386 -arch ppc
  CXXFLAGS += -isysroot /Developer/SDKs/MacOSX10.4u.sdk -arch i386 -arch ppc
  LDFLAGS += -isysroot /Developer/SDKs/MacOSX10.4u.sdk -arch i386 -arch ppc
endif

VERSION=$(shell expr download/ncurses-*.tar.gz : 'download/ncurses-\(.*\).tar.gz')

.PHONY: all
all: ncurses-install.tag clean

ncurses-download.tag:
	wget -P download http://ftp.gnu.org/pub/gnu/ncurses/ncurses-5.6.tar.gz
	touch $@

ncurses-unpack.tag: ncurses-download.tag
	tar xzvf download/ncurses-$(VERSION).tar.gz
	touch $@

ncurses-configure.tag: ncurses-unpack.tag
	cd ncurses-$(VERSION) && \
	./configure --prefix=$(LOCAL_DIR) CFLAGS="$(CFLAGS)" CXXFLAGS="$(CXXFLAGS)" LDFLAGS="$(LDFLAGS)"
	touch $@

ncurses-make.tag: ncurses-configure.tag
	$(MAKE) -C ncurses-$(VERSION)
	touch $@

ncurses-install.tag: ncurses-make.tag
	$(MAKE) -C ncurses-$(VERSION) install
	touch $@

clean:
	rm -rf ncurses-$(VERSION) download/* *.tag
