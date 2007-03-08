# Generate 32 bit i386 mingw executables on
# AMD Sempron with Fedora Core release 6

# Spawn 2 make proceses
MAKEJOBFLAGS = -j 2

CROSSCOMPILING = 1

TOOLSPREFIX = $(HOME)/local-$(HOSTNAME)/cross-tools/bin/i586-mingw32msvc-

PREFIX = /sdcc

SDCCCONFIGUREFLAGS = \
--prefix=$(PREFIX) \
--datarootdir=/sdcc \
docdir=$${datarootdir}/doc \
include_dir_suffix=include \
lib_dir_suffix=lib \
sdccconf_h_dir_separator=\\\\ \
--disable-device-lib
EXEEXTENSION = .exe
