# Dual processor
MAKEJOBFLAGS = -j 2
CROSSCOMPILING = 1
TOOLSPREFIX = $(HOME)/local/cross-tools/bin/i586-mingw32msvc-
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
