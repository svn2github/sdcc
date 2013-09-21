include ../packages.mk

ifeq ($(OS), Darwin)
  LIBTOOLIZE = glibtoolize
else
  LIBTOOLIZE = libtoolize
endif

.PHONY: all
all: gpsim-install.tag clean

gpsim-download.tag:
	svn --force export svn+ssh://borutr@svn.code.sf.net/p/gpsim/code/trunk gpsim
	touch $@

gpsim-configure.tag: gpsim-download.tag
	cd gpsim && \
	$(LIBTOOLIZE) --force && \
	aclocal && \
	autoheader && \
	automake --add-missing && \
	autoconf && \
	./configure --prefix=$(LOCAL_DIR) --disable-gui CFLAGS="$(CFLAGS)" CXXFLAGS="$(CXXFLAGS)" LDFLAGS="$(LDFLAGS)"
	touch $@

gpsim-make.tag: gpsim-configure.tag
	$(MAKE) -C gpsim
	touch $@

gpsim-install.tag: gpsim-make.tag
	$(MAKE) -C gpsim install
	touch $@

clean:
	rm -rf gpsim *.tag
