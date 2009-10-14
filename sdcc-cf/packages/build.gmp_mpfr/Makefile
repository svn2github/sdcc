include ../packages.mk

GMP_VERSION = $(shell expr download/gmp-*.tar.bz2 : 'download/gmp-\(.*\).tar.bz2')
MPFR_VERSION = $(shell expr download/mpfr-*.tar.bz2 : 'download/mpfr-\(.*\).tar.bz2')
GMP_DIR = gmp-$(GMP_VERSION)
MPFR_DIR = mpfr-$(MPFR_VERSION)

.PHONY: all
all: gmp-install.tag gmp-clean mpfr-install.tag mpfr-clean

.PHONY: clean
clean: gmp-clean mpfr-clean
	rm -rf download/* *.tag


gmp-download.tag:
	wget -P download ftp://ftp.gnu.org/gnu/gmp/gmp-4.2.4.tar.bz2
	touch $@

gmp-unpack.tag: gmp-download.tag
	tar xjf download/$(GMP_DIR).tar.bz2
	touch $@

gmp-configure.tag: gmp-unpack.tag
	cd $(GMP_DIR) && \
	./configure --prefix=$(LOCAL_DIR)
	touch $@

gmp-make.tag: gmp-configure.tag
	make -C $(GMP_DIR)
	touch $@

gmp-install.tag: gmp-make.tag
	make -C $(GMP_DIR) install
	touch $@

.PHONY: gmp-clean
gmp-clean:
	rm -rf $(GMP_DIR) gmp-*.tag

	
mpfr-download.tag:
	wget -P download http://www.mpfr.org/mpfr-current/mpfr-2.4.1.tar.bz2
	touch $@

mpfr-unpack.tag: mpfr-download.tag
	tar xjf download/$(MPFR_DIR).tar.bz2
	touch $@

mpfr-configure.tag: mpfr-unpack.tag
	cd $(MPFR_DIR) && \
	./configure --prefix=$(LOCAL_DIR)
	touch $@

mpfr-make.tag: mpfr-configure.tag
	make -C $(MPFR_DIR)
	touch $@

mpfr-install.tag: mpfr-make.tag
	make -C $(MPFR_DIR) install
	touch $@

.PHONY: mpfr-clean
mpfr-clean:
	rm -rf $(MPFR_DIR) mpfr-*.tag
