include ../packages.mk

.PHONY: all
all: gpsim-install.tag clean

gpsim-download.tag:
	svn --force export https://svn.sourceforge.net/svnroot/gpsim/trunk gpsim
	touch $@

gpsim-configure.tag: gpsim-download.tag
	cd gpsim && \
	libtoolize --force && \
	aclocal && \
	autoheader && \
	automake --add-missing && \
	autoconf && \
	./configure --prefix=$(LOCAL_DIR) --disable-gui
	touch $@

gpsim-make.tag: gpsim-configure.tag
	$(MAKE) -C gpsim
	touch $@
	
gpsim-install.tag: gpsim-make.tag
	$(MAKE) -C gpsim install
	touch $@

clean:
	rm -rf gpsim *.tag
