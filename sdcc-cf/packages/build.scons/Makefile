include ../packages.mk

VERSION=$(shell expr download/scons-*.tar.gz : 'download/scons-\(.*\).tar.gz')

.PHONY: all
all: scons-install.tag clean

scons-download.tag:
	wget -P download http://prdownloads.sourceforge.net/scons/scons-0.96.95.tar.gz
	touch $@

scons-unpack.tag: scons-download.tag
	tar xzvf download/scons-*.tar.gz
	touch $@

scons-install.tag: scons-unpack.tag
	cd scons-$(VERSION) && \
	python setup.py install --prefix=$(LOCAL_DIR)
	touch $@

clean:
	rm -rf scons-$(VERSION) download/* *.tag
