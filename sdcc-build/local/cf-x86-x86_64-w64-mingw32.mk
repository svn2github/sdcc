# Generate 64 bit x86_64 mingw_w64 executables on
# AMD Sempron with Fedora Core release 6

# Spawn 2 make proceses
MAKEJOBFLAGS = -j 2

CROSSCOMPILING = 1

TOOLSPREFIX = $(HOME)/local-$(HOSTNAME)/cross-tools-w64/bin/x86_64-w64-mingw32-

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
TARGETLDFLAGS = -Wl,--stack,67108864
