include ../packages.mk

PACKAGE=boost
VERSION=1_45_0
PACKAGE_FILE=$(PACKAGE)_$(VERSION).tar.bz2

PACKAGE_DIR=$(PACKAGE)_$(VERSION)

.PHONY: all
all: $(PACKAGE)-install.tag clean

download/$(PACKAGE_FILE):
	wget -P download http://sourceforge.net/projects/boost/files/boost/1.45.0/$(PACKAGE_FILE)/download

$(PACKAGE)-download.tag: download/$(PACKAGE_FILE)
	touch $@

$(PACKAGE)-unpack.tag: $(PACKAGE)-download.tag
	tar xjvf download/$(PACKAGE_FILE)
	touch $@

$(PACKAGE)-configure.tag: $(PACKAGE)-unpack.tag
	cd $(PACKAGE_DIR) && \
	./bootstrap.sh --prefix=$(LOCAL_DIR)
	touch $@

$(PACKAGE)-make.tag: $(PACKAGE)-configure.tag
	cd $(PACKAGE_DIR) && \
	./bjam
	touch $@

$(PACKAGE)-install.tag: $(PACKAGE)-make.tag
	mv $(PACKAGE_DIR)/boost $(LOCAL_DIR)/include
	mv $(PACKAGE_DIR)/stage/lib/* $(LOCAL_DIR)/lib
	touch $@

clean:
	rm -rf $(PACKAGE_DIR) *.tag
