include ../packages.mk

BINUTILS_VERSION=2.22
MINGWRT_VERSION=3.20
W32API_DIR_VERSION=3.17
W32API_VERSION=$(W32API_DIR_VERSION)-2
#GCC_VERSION=4.6.1
#GCC_SEPARATE_PACKAGES=1
GCC_VERSION=4.7.0

TARGET=i586-mingw32msvc
PROGRAM_PREFIX=i586-mingw32msvc-
PREFIX=$(LOCAL_DIR)/cross-tools

.PHONY: all
all: binutils-install.tag binutils-clean \
     mingw-runtime-install.tag \
     w32api-install.tag \
     gcc-install.tag gcc-clean

.PHONY: clean
clean: binutils-clean mingw-runtime-clean w32api-clean gcc-clean
	rm -rf download/* *.tag

.PHONY: real-clean
real-clean: binutils-realclean mingw-runtime-realclean w32api-realclean gcc-realclean
	rm -rf $(PREFIX)


download/binutils-$(BINUTILS_VERSION).tar.bz2:
	wget -nv -P download http://ftp.gnu.org/gnu/binutils/binutils-$(BINUTILS_VERSION).tar.bz2

binutils-unpack.tag: download/binutils-$(BINUTILS_VERSION).tar.bz2
	tar -xjf download/binutils-$(BINUTILS_VERSION).tar.bz2
	touch $@

binutils-configure.tag: binutils-unpack.tag
	cd $(shell find . -maxdepth 1 -type d -name "binutil*") && \
	./configure --target=$(TARGET) --program-prefix=$(PROGRAM_PREFIX) --prefix=$(PREFIX) \
	  --with-gcc --with-gnu-as --with-gnu-ld \
	  --disable-nls --disable-shared
	touch $@

binutils-make.tag: binutils-configure.tag
	cd $(shell find . -maxdepth 1 -type d -name "binutil*") && \
	make
	touch $@

binutils-install.tag: binutils-make.tag
	cd $(shell find . -maxdepth 1 -type d -name "binutil*") && \
	make install
	find $(PREFIX)/bin/ -type f -exec sh -c "file {} | grep executable > /dev/null && strip {}" \;
	#strip $(PREFIX)/bin/*
	touch $@


.PHONY: binutils-clean
binutils-clean:
	rm -rf $(shell find . -maxdepth 1 -type d -name "binutil*")

.PHONY: binutils-realclean
binutils-realclean: binutils-clean
	rm -rf binutils-*


download/mingwrt-$(MINGWRT_VERSION)-mingw32-dev.tar.gz:
	wget -nv -P download http://sourceforge.net/projects/mingw/files/MinGW/Base/mingw-rt/mingwrt-$(MINGWRT_VERSION)/mingwrt-$(MINGWRT_VERSION)-mingw32-dev.tar.gz

mingw-runtime-install.tag: download/mingwrt-$(MINGWRT_VERSION)-mingw32-dev.tar.gz
	mkdir -p $(PREFIX)/$(TARGET)/include
	mkdir -p $(PREFIX)/$(TARGET)/lib
	tar -C $(PREFIX)/$(TARGET) -xzf download/mingwrt-$(MINGWRT_VERSION)-mingw32-dev.tar.gz
	touch $@

.PHONY: mingw-runtime-clean
mingw-runtime-clean:
	rm -f mingw-runtime-install.tag

.PHONY: mingw-runtime-realclean
mingw-runtime-realclean: mingw-runtime-clean
	rm -f mingw-runtime-download.tag


download/w32api-$(W32API_VERSION)-mingw32-dev.tar.lzma:
	wget -nv -P download http://sourceforge.net/projects/mingw/files/MinGW/Base/w32api/w32api-$(W32API_DIR_VERSION)/w32api-$(W32API_VERSION)-mingw32-dev.tar.lzma

w32api-install.tag: download/w32api-$(W32API_VERSION)-mingw32-dev.tar.lzma
	mkdir -p $(PREFIX)/$(TARGET)/include
	mkdir -p $(PREFIX)/$(TARGET)/lib
	tar -C $(PREFIX)/$(TARGET) --lzma -xf download/w32api-$(W32API_VERSION)-mingw32-dev.tar.lzma
	touch $@

.PHONY: w32api-clean
w32api-clean:
	rm -f w32api-install.tag

.PHONY: w32api-realclean
w32api-realclean: w32api-clean
	rm -f w32api-download.tag


ifdef GCC_SEPARATE_PACKAGES
download/gcc-core-$(GCC_VERSION).tar.bz2:
	wget -nv -P download ftp://ftp.gnu.org/gnu/gcc/gcc-$(GCC_VERSION)/gcc-core-$(GCC_VERSION).tar.bz2

download/gcc-g++-$(GCC_VERSION).tar.bz2:
	wget -nv -P download ftp://ftp.gnu.org/gnu/gcc/gcc-$(GCC_VERSION)/gcc-g++-$(GCC_VERSION).tar.bz2

gcc-unpack.tag: download/gcc-core-$(GCC_VERSION).tar.bz2 download/gcc-g++-$(GCC_VERSION).tar.bz2
	for i in $^; do \
	  tar -xjf $$i; \
	done
	#bunzip2 -c download/gcc*.tar.bz2 | tar -xf -
	touch $@
else
download/gcc-$(GCC_VERSION).tar.bz2:
	wget -nv -P download ftp://ftp.gnu.org/gnu/gcc/gcc-$(GCC_VERSION)/gcc-$(GCC_VERSION).tar.bz2

gcc-unpack.tag: download/gcc-$(GCC_VERSION).tar.bz2
	tar -xjf download/gcc-$(GCC_VERSION).tar.bz2
	touch $@
endif

gcc-configure.tag: gcc-unpack.tag
	rm -rf objdir-gcc
	mkdir -p objdir-gcc
	cd objdir-gcc && \
	../gcc-$(GCC_VERSION)/configure \
	  --target=$(TARGET) --program-prefix=$(PROGRAM_PREFIX) --prefix=$(PREFIX) \
	  --enable-languages=c,c++ \
	  --with-gcc --with-gnu-ld --with-gnu-as \
	  --with-gmp=$(LOCAL_DIR) --with-mpfr=$(LOCAL_DIR) --with-mpc=$(LOCAL_DIR) \
	  --enable-threads --disable-nls \
	  --disable-multilib --enable-win32-registry --disable-shared
	touch $@

gcc-make.tag: gcc-configure.tag
	cd objdir-gcc && \
	PATH=$(PATH):$(PREFIX)/bin \
	make LDFLAGS=-s -j 2
	touch $@

gcc-install.tag: gcc-make.tag
	cd objdir-gcc && \
	PATH=$(PATH):$(PREFIX)/bin \
	make install
	rm -r $(PREFIX)/man $(PREFIX)/info
	touch $@

.PHONY: gcc-clean
gcc-clean:
	rm -rf $(shell find . -maxdepth 1 -type d -name "gcc*")
	rm -rf objdir-gcc
	rm -f gcc-unpack.tag gcc-configure.tag gcc-make.tag

.PHONY: gcc-realclean
