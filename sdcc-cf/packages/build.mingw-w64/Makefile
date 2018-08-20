include ../packages.mk

MINGW_W64_VERSION=1.0
MINGW_W64_BUILD_DATE=20120227
BINUTILS_VERSION=2.28
GCC_VERSION=4.9.4

TARGET=x86_64-w64-mingw32
PROGRAM_PREFIX=$(TARGET)-
PREFIX=$(LOCAL_DIR)/cross-tools-w64

.PHONY: all
all: mingw-w64-install.tag binutils-install.tag gcc-install.tag \
     mingw-w64-clean binutils-clean gcc-clean

.PHONY: clean
clean: mingw-w64-clean binutils-clean gcc-clean
	rm -rf download/*

.PHONY: real-clean
real-clean: clean
	rm -rf $(PREFIX)

download/mingw-w64-$(MINGW_W64_VERSION)-bin_x86_64-linux_$(MINGW_W64_BUILD_DATE).tar.bz2:
####download/mingw-w64-bin_x86_64-linux_$(MINGW_W64_BUILD_DATE).tar.bz2:
	wget -nv -P download http://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win64/Automated%20Builds/mingw-w64-$(MINGW_W64_VERSION)-bin_x86_64-linux_$(MINGW_W64_BUILD_DATE).tar.bz2

mingw-w64-install.tag: download/mingw-w64-$(MINGW_W64_VERSION)-bin_x86_64-linux_$(MINGW_W64_BUILD_DATE).tar.bz2
#####mingw-w64-install.tag: download/mingw-w64-bin_x86_64-linux_$(MINGW_W64_BUILD_DATE).tar.bz2
	mkdir -p $(LOCAL_DIR)/cross-tools-w64
	tar -C $(LOCAL_DIR)/cross-tools-w64 -xjvf download/mingw-w64-$(MINGW_W64_VERSION)-bin_x86_64-linux_$(MINGW_W64_BUILD_DATE).tar.bz2
	test -L $(LOCAL_DIR)/cross-tools-w64/x86_64-w64-mingw32/include/boost && rm $(LOCAL_DIR)/cross-tools-w64/x86_64-w64-mingw32/include/boost; true
	ln -s /usr/include/boost/ $(LOCAL_DIR)/cross-tools-w64/x86_64-w64-mingw32/include
	touch $@

.PHONY: mingw-w64-clean
mingw-w64-clean:
	rm -rf mingw-w64-*.tag


download/binutils-$(BINUTILS_VERSION).tar.bz2:
download/binutils-$(BINUTILS_VERSION).tar.gz:
	wget -nv -P download http://ftp.gnu.org/gnu/binutils/binutils-$(BINUTILS_VERSION).tar.bz2

binutils-unpack.tag: download/binutils-$(BINUTILS_VERSION).tar.bz2
binutils-unpack.tag: download/binutils-$(BINUTILS_VERSION).tar.gz
	tar -xjf download/binutils-$(BINUTILS_VERSION).tar.bz2
	touch $@

binutils-configure.tag: binutils-unpack.tag
	cd $(shell find . -maxdepth 1 -type d -name "binutil*") && \
	./configure --target=$(TARGET) --program-prefix=$(PROGRAM_PREFIX) --prefix=$(PREFIX)  \
	    --with-gcc --with-gnu-as --with-gnu-ld      \
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
	rm -rf binutils-*.tag


download/gcc-$(GCC_VERSION).tar.bz2:
	wget -nv -P download ftp://ftp.gnu.org/gnu/gcc/gcc-$(GCC_VERSION)/gcc-$(GCC_VERSION).tar.bz2

gcc-unpack.tag: download/gcc-$(GCC_VERSION).tar.bz2
	tar -xjf download/gcc-$(GCC_VERSION).tar.bz2
	touch $@

gcc-configure.tag: gcc-unpack.tag
	rm -rf objdir-gcc
	mkdir -p objdir-gcc
	cd objdir-gcc && \
	../$(shell find . -maxdepth 1 -type d -name "gcc*")/configure \
	  --target=$(TARGET) --program-prefix=$(PROGRAM_PREFIX) --prefix=$(PREFIX) \
	  --with-gcc --with-gnu-ld --with-gnu-as \
	  --with-gmp=$(LOCAL_DIR) --with-mpfr=$(LOCAL_DIR) --with-mpc=$(LOCAL_DIR) \
	  --enable-threads --disable-nls --enable-languages=c,c++ \
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
	touch $@

.PHONY: gcc-clean
gcc-clean:
	rm -rf $(shell find . -maxdepth 1 -type d -name "gcc*")
	rm -rf objdir-gcc
	rm -f gcc-*.tag
