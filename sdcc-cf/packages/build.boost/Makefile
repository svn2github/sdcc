include ../packages.mk

PACKAGE=boost
ifeq ($(OS),SunOS)
# boost 1_45_0 and newer doesn't compile on Solaris gcc
  VERSION=1_44_0
  PACKAGE_FILE=$(PACKAGE)_$(VERSION).zip
#  WITH_TOOLSET=--with-toolset=sun
  WITH_TOOLSET=
else
  VERSION=1_47_0
  PACKAGE_FILE=$(PACKAGE)_$(VERSION).tar.bz2
  WITH_TOOLSET=
endif

ifeq ($(HOSTNAME),mypants)
  BJAM_FLAGS=pch=off
else
#  # universal build on Mac OS X doesn't work
#  ifeq ($(OS), Darwin)
#    # Build universal binaries
#    BJAM_FLAGS=macosx-version=10.5 macosx-version-min=10.4 architecture=combined threading=multi link=static address-model=32
#  else
    BJAM_FLAGS=
#  endif
endif

SUBDIR:=$(shell echo $(VERSION) | sed -e 's/_/./g')
PACKAGE_DIR=$(PACKAGE)_$(VERSION)

.PHONY: all
all: $(PACKAGE)-install.tag clean

download/$(PACKAGE_FILE):
	wget -P download http://sourceforge.net/projects/boost/files/boost/$(SUBDIR)/$(PACKAGE_FILE)/download

$(PACKAGE)-download.tag: download/$(PACKAGE_FILE)
	touch $@

$(PACKAGE)-unpack.tag: $(PACKAGE)-download.tag
ifeq ($(OS),SunOS)
	unzip download/$(PACKAGE_FILE)
	find $(PACKAGE_DIR) -type f -exec dos2unix {} {} \;
	find $(PACKAGE_DIR) -name '*.sh' -exec chmod +x {} \;
else
	tar xjvf download/$(PACKAGE_FILE)
endif
	touch $@

$(PACKAGE)-configure.tag: $(PACKAGE)-unpack.tag
ifndef INCLUDES_ONLY
	cd $(PACKAGE_DIR) && \
	./bootstrap.sh $(WITH_TOOLSET) --prefix=$(LOCAL_DIR) --includedir=$(LOCAL_DIR)/include/boost
endif
	touch $@

$(PACKAGE)-make.tag: $(PACKAGE)-configure.tag
ifndef INCLUDES_ONLY
	cd $(PACKAGE_DIR) && \
	./bjam $(BJAM_FLAGS)
endif
	touch $@

$(PACKAGE)-install.tag: $(PACKAGE)-make.tag
	test -d $(LOCAL_DIR)/include || mkdir $(LOCAL_DIR)/include
	test -d $(LOCAL_DIR)/include/boost && rm -rf $(LOCAL_DIR)/include/boost
	mv $(PACKAGE_DIR)/boost $(LOCAL_DIR)/include/
ifndef INCLUDES_ONLY
	test -d $(LOCAL_DIR)/lib || mkdir $(LOCAL_DIR)/lib
	rm $(LOCAL_DIR)/lib/libboost_*
	mv $(PACKAGE_DIR)/stage/lib/* $(LOCAL_DIR)/lib
endif
	touch $@

clean:
	rm -rf $(PACKAGE_DIR) *.tag
