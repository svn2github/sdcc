include ../packages.mk

PACKAGE=boost
ifeq ($(OS),SunOS)
  VERSION=1_49_0
  PACKAGE_FILE=$(PACKAGE)_$(VERSION).zip
#  WITH_TOOLSET=--with-toolset=sun
  WITH_TOOLSET=--with-toolset=
else
  VERSION=1_50_0
  PACKAGE_FILE=$(PACKAGE)_$(VERSION).tar.bz2
  ifeq ($(OS), Darwin)
    WITH_TOOLSET=--with-toolset=darwin
  else
    WITH_TOOLSET=
  endif
endif

BJAM_FLAGS=link=static

ifeq ($(HOSTNAME),mypants)
  BJAM_FLAGS+= pch=off
else
#  # universal build on Mac OS X doesn't work
#  ifeq ($(OS), Darwin)
#    # Build universal binaries
#    BJAM_FLAGS=macosx-version=10.5 macosx-version-min=10.4 architecture=combined threading=multi link=static address-model=32
#  endif
endif

SUBDIR:=$(shell echo $(VERSION) | sed -e 's/_/./g')
PACKAGE_DIR=$(PACKAGE)_$(VERSION)

.PHONY: all
all: $(PACKAGE)-install.tag clean

download/$(PACKAGE_FILE):
	wget -P download http://sourceforge.net/projects/boost/files/boost/$(SUBDIR)/$(PACKAGE_FILE)

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
	./bootstrap.sh $(WITH_TOOLSET) --prefix=$(LOCAL_DIR) --with-libraries=graph
endif
	touch $@

$(PACKAGE)-make.tag: $(PACKAGE)-configure.tag
ifndef INCLUDES_ONLY
	cd $(PACKAGE_DIR) && \
	./bjam $(BJAM_FLAGS)
endif
	touch $@

$(PACKAGE)-install.tag: $(PACKAGE)-make.tag
ifdef INCLUDES_ONLY
	test -d $(LOCAL_DIR)/include || mkdir $(LOCAL_DIR)/include
	-test -d $(LOCAL_DIR)/include/boost && rm -rf $(LOCAL_DIR)/include/boost
	mv $(PACKAGE_DIR)/boost $(LOCAL_DIR)/include/
else
	cd $(PACKAGE_DIR) && \
	./bjam $(BJAM_FLAGS) install
endif
	touch $@

clean:
	rm -rf $(PACKAGE_DIR) *.tag
