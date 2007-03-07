include ../packages.mk

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


binutils-download.tag:
	wget -P download http://ftp.gnu.org/gnu/binutils/binutils-2.16.1.tar.bz2
	touch $@

binutils-unpack.tag: binutils-download.tag
	tar -xjf download/binutils*.tar.bz2
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

.PHONY: binutils-realclean
binutils-realclean: binutils-clean
	rm -rf binutils-*



mingw-runtime-download.tag:
	wget -P download $(SF_REPOSITORY)/sourceforge/mingw/mingw-runtime-3.9.tar.gz
	touch $@

mingw-runtime-install.tag: mingw-runtime-download.tag
	mkdir -p $(PREFIX)/$(TARGET)/include
	mkdir -p $(PREFIX)/$(TARGET)/lib
	tar -xzf download/mingw-runtime*.tar.gz -C $(PREFIX)/$(TARGET)
	touch $@

.PHONY: mingw-runtime-clean
mingw-runtime-clean:
	rm -f mingw-runtime-install.tag

.PHONY: mingw-runtime-realclean
mingw-runtime-realclean: mingw-runtime-clean
	rm -f mingw-runtime-download.tag


w32api-download.tag:
	wget -P download $(SF_REPOSITORY)/sourceforge/mingw/w32api-3.8.tar.gz
	touch $@

w32api-install.tag: w32api-download.tag
	mkdir -p $(PREFIX)/$(TARGET)/include
	mkdir -p $(PREFIX)/$(TARGET)/lib
	tar -C $(PREFIX)/$(TARGET) -xzf download/w32api*.tar.gz
	touch $@

.PHONY: w32api-clean
w32api-clean:
	rm -f w32api-install.tag

.PHONY: w32api-realclean
w32api-realclean: w32api-clean
	rm -f w32api-download.tag


gcc-download.tag:
	wget -P download ftp://ftp.gnu.org/gnu/gcc/gcc-4.1.2/gcc-core-4.1.2.tar.bz2
	wget -P download ftp://ftp.gnu.org/gnu/gcc/gcc-4.1.2/gcc-g++-4.1.2.tar.bz2
	touch $@

gcc-unpack.tag: gcc-download.tag
	for i in download/gcc*.tar.bz2; do \
	  tar -xjf $$i;	\
	done
	#bunzip2 -c download/gcc*.tar.bz2 | tar -xf -
	touch $@

gcc-configure.tag: gcc-unpack.tag
	rm -rf objdir-gcc
	mkdir -p objdir-gcc
	cd objdir-gcc &&	\
	../$(shell find . -maxdepth 1 -type d -name "gcc*")/configure	\
	  --target=$(TARGET) --program-prefix=$(PROGRAM_PREFIX) --prefix=$(PREFIX)  \
	  --with-gcc --with-gnu-ld --with-gnu-as			\
	  --enable-threads   --disable-nls   --enable-languages=c,c++	\
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
gcc-realclean: gcc-clean
	rm -rf gcc-download.tag
