include ../packages.mk

VERSION=3.0.8

RSYNC_DIR=rsync-$(VERSION)

.PHONY: all
all: rsync-install.tag clean

download/rsync-$(VERSION).tar.gz:
	wget -P download ftp://ftp.samba.org/pub/rsync/rsync-$(VERSION).tar.gz

rsync-download.tag: download/rsync-$(VERSION).tar.gz
	touch $@

rsync-unpack.tag: rsync-download.tag
	tar xzvf download/$(RSYNC_DIR).tar.gz
	touch $@

rsync-configure.tag: rsync-unpack.tag
	cd $(RSYNC_DIR) && \
	./configure --prefix=$(LOCAL_DIR)
	touch $@

rsync-make.tag: rsync-configure.tag
	$(MAKE) -C $(RSYNC_DIR)
	touch $@

rsync-install.tag: rsync-make.tag
	$(MAKE) -C $(RSYNC_DIR) install
	touch $@

clean:
	rm -rf $(RSYNC_DIR) *.tag
