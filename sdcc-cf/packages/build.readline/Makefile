include ../packages.mk

ifeq ($(OS), Darwin)
  # Build universal binaries
  CFLAGS = -g -O2 -isysroot $(XCODE_ROOT)/SDKs/MacOSX10.4u.sdk -arch i386 -arch ppc -DNEED_EXTERN_PC
  CXXFLAGS = -g -O2 -isysroot $(XCODE_ROOT)/SDKs/MacOSX10.4u.sdk -arch i386 -arch ppc -DNEED_EXTERN_PC
  LDFLAGS = -g -O2 -arch i386 -arch ppc
  CONFFLAGS = --disable-dependency-tracking
endif

FLAGS =
ifdef CFLAGS
  FLAGS += CFLAGS="$(CFLAGS)"
endif
ifdef CXXFLAGS
  FLAGS += CXXFLAGS="$(CXXFLAGS)"
endif
ifdef LDFLAGS
  FLAGS += LDFLAGS="$(LDFLAGS)"
endif
ifdef CONFFLAGS
  FLAGS += CONFFLAGS="$(CONFFLAGS)"
endif

PACKAGE=readline
VERSION=6.2
PACKAGE_DIR=$(PACKAGE)-$(VERSION)
PACKAGE_FILE=$(PACKAGE_DIR).tar.gz

.PHONY: all
all: $(PACKAGE)-install.tag clean

download/$(PACKAGE_FILE):
	wget -P download ftp://ftp.cwru.edu/pub/bash/$(PACKAGE_FILE)

$(PACKAGE)-download.tag: download/$(PACKAGE_FILE)
	touch $@

$(PACKAGE)-unpack.tag: $(PACKAGE)-download.tag
	tar xzvf download/$(PACKAGE_FILE)
	touch $@

$(PACKAGE)-configure.tag: $(PACKAGE)-unpack.tag
	cd $(PACKAGE_DIR) && \
	./configure --prefix=$(LOCAL_DIR) $(CONFFLAGS) $(FLAGS)
	touch $@

$(PACKAGE)-make.tag: $(PACKAGE)-configure.tag
	$(MAKE) -C $(PACKAGE_DIR)
	touch $@

$(PACKAGE)-install.tag: $(PACKAGE)-make.tag
	$(MAKE) -C $(PACKAGE_DIR) install
	touch $@

clean:
	rm -rf $(PACKAGE_DIR) download/* *.tag
