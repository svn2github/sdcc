include ../packages.mk

PACKAGE=wine

VERSION=1.2.3

WINE_DIR=$(PACKAGE)-$(VERSION)

CFGFLAGS=--without-x --without-freetype --prefix=$(LOCAL_DIR) CFLAGS="$(CFLAGS)" CXXFLAGS="$(CXXFLAGS)" LDFLAGS="$(LDFLAGS)"
ifdef WINE64
  ENABLE_WIN64=--enable-win64
  WITH_WINE64=--with-wine64=../wine64
endif

.PHONY: all
all: $(PACKAGE)-install.tag clean

download/$(PACKAGE)-$(VERSION).tar.bz2:
	wget -nv -P download http://sourceforge.net/projects/wine/files/Source/$(PACKAGE)-$(VERSION).tar.bz2

$(PACKAGE)-unpack.tag: download/$(PACKAGE)-$(VERSION).tar.bz2
	tar xjvf download/$(PACKAGE)-$(VERSION).tar.bz2
	touch $@

ifdef WINE64
$(PACKAGE)64-configure.tag: $(PACKAGE)-unpack.tag
	mkdir wine64
	cd wine64 && \
	../$(WINE_DIR)/configure $(ENABLE_WIN64) $(CFGFLAGS)

$(PACKAGE)64-make.tag: $(PACKAGE)64-configure.tag
	$(MAKE) -C wine64
endif

$(PACKAGE)32-configure.tag: $(PACKAGE)-unpack.tag
	mkdir wine32
	cd wine32 && \
	../$(WINE_DIR)/configure $(WITH_WINE64) $(CFGFLAGS)
	touch $@

$(PACKAGE)32-make.tag: $(PACKAGE)32-configure.tag
	$(MAKE) -C wine32
	touch $@

ifdef WINE64
$(PACKAGE)-install.tag: $(PACKAGE)64-make.tag $(PACKAGE)32-make.tag
	$(MAKE) -C wine64 install prefix=$(LOCAL_DIR)
	$(MAKE) -C wine32 install prefix=$(LOCAL_DIR)
	touch $@
else
$(PACKAGE)-install.tag: $(PACKAGE)32-make.tag
	$(MAKE) -C wine32 install prefix=$(LOCAL_DIR)
	touch $@
endif

.PHONY: clean
clean:
	rm -rf $(WINE_DIR) wine64 wine32 download/* *.tag
