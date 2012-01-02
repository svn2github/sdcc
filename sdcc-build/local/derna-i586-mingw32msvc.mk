# Generate 32 bit i386 mingw executables on
# Debian on i686

# Spawn 2 make proceses
MAKEJOBFLAGS = -j 2

CROSSCOMPILING = 1

TOOLSPREFIX = $(HOME)/local-$(HOSTNAME)/cross-tools/bin/i586-mingw32msvc-

PREFIX = /sdcc

CC_FOR_BUILD = gcc

SDCCCONFIGUREFLAGS = \
--prefix=$(PREFIX) \
--datarootdir=/sdcc \
docdir=$${datarootdir}/doc \
include_dir_suffix=include \
non_free_include_dir_suffix=non-free/include \
lib_dir_suffix=lib \
non_free_lib_dir_suffix=non-free/lib \
sdccconf_h_dir_separator=\\\\ \
--disable-device-lib
EXEEXTENSION = .exe

TARGETCXXFLAGS = -O2
TARGETCFLAGS = -O2
TARGETLDFLAGS = -Wl,--stack,33554432
