include ../packages.mk

#GCC_VERSION=4.6.1
#GCC_SEPARATE_PACKAGES=1
GCC_VERSION=4.7.2

ifeq ($(OS),SunOS)
  CFGFLAGS=--with-as=/usr/ccs/bin/as --with-ld=/usr/ccs/bin/ld --disable-lto
#  CFGENV=CC='cc -m64'
endif

.PHONY: all
all: gcc-install.tag gcc-clean

.PHONY: clean
clean: gcc-clean
	rm -rf download/* *.tag

ifdef GCC_SEPARATE_PACKAGES
download/gcc-core-$(GCC_VERSION).tar.bz2:
	$(WGET) ftp://ftp.gnu.org/gnu/gcc/gcc-$(GCC_VERSION)/gcc-core-$(GCC_VERSION).tar.bz2

download/gcc-g++-$(GCC_VERSION).tar.bz2:
	$(WGET) ftp://ftp.gnu.org/gnu/gcc/gcc-$(GCC_VERSION)/gcc-g++-$(GCC_VERSION).tar.bz2

gcc-unpack.tag: download/gcc-core-$(GCC_VERSION).tar.bz2 download/gcc-g++-$(GCC_VERSION).tar.bz2
	for i in $^; do \
	  tar -xjf $$i; \
	done
	#bunzip2 -c download/gcc*.tar.bz2 | tar -xf -
	touch $@
else
download/gcc-$(GCC_VERSION).tar.bz2:
	$(WGET) ftp://ftp.gnu.org/gnu/gcc/gcc-$(GCC_VERSION)/gcc-$(GCC_VERSION).tar.bz2

gcc-unpack.tag: download/gcc-$(GCC_VERSION).tar.bz2
	tar -xjf download/gcc-$(GCC_VERSION).tar.bz2
	touch $@
endif

gcc-configure.tag: gcc-unpack.tag
	rm -rf objdir-gcc
	mkdir -p objdir-gcc
	cd objdir-gcc && \
	../gcc-$(GCC_VERSION)/configure \
	  --prefix=$(LOCAL_DIR) \
	  --enable-languages=c,c++ \
	  --with-gmp=$(LOCAL_DIR) --with-mpfr=$(LOCAL_DIR) --with-mpc=$(LOCAL_DIR) \
	  --enable-threads --disable-nls \
	  --disable-shared $(CFGFLAGS) $(CFGENV)
	touch $@

gcc-make.tag: gcc-configure.tag
	cd objdir-gcc && \
	PATH=$(PATH):$(LOCAL_DIR)/bin \
	make LDFLAGS=-s -j 2
	touch $@

gcc-install.tag: gcc-make.tag
	cd objdir-gcc && \
	PATH=$(PATH):$(LOCAL_DIR)/bin \
	make install
	rm -r $(LOCAL_DIR)/man $(LOCAL_DIR)/info
	touch $@


.PHONY: gcc-clean
gcc-clean:
	rm -rf gcc-$(GCC_VERSION)
	rm -rf objdir-gcc
	rm -f gcc-unpack.tag gcc-configure.tag gcc-make.tag
