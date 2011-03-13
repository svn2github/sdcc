include ../packages.mk

PACKAGE=boost
VERSION=1_45_0
SUBDIR:=$(shell echo $(VERSION) | sed -e 's/_/./g')
ifeq ($(OS),SunOS)
  PACKAGE_FILE=$(PACKAGE)_$(VERSION).zip
  WITH_TOOLSET=--with_toolset=sun
else
  PACKAGE_FILE=$(PACKAGE)_$(VERSION).tar.bz2
  WITH_TOOLSET=
endif

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
	./bjam
endif
	touch $@

$(PACKAGE)-install.tag: $(PACKAGE)-make.tag
	mkdir $(LOCAL_DIR)/include
	mv $(PACKAGE_DIR)/boost $(LOCAL_DIR)/include/
ifndef INCLUDES_ONLY
	mv $(PACKAGE_DIR)/stage/lib/* $(LOCAL_DIR)/lib
endif
	touch $@

clean:
	rm -rf $(PACKAGE_DIR) *.tag
