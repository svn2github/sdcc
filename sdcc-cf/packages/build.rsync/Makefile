include ../packages.mk

VERSION=$(shell expr download/rsync-*.tar.gz : 'download/rsync-\(.*\).tar.gz')

RSYNC_DIR=rsync-$(VERSION)

.PHONY: all
all: rsync-install.tag clean

rsync-download.tag:
	wget -P download ftp://ftp.samba.org/pub/rsync/rsync-3.0.7.tar.gz
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
