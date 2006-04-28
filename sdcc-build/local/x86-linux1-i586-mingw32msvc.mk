# Dual processor
MAKEJOBFLAGS = -j 2
CROSSCOMPILING = 1
TOOLSPREFIX = $(HOME)/local/cross-tools/bin/i586-mingw32msvc-
SDCCCONFIGUREFLAGS = \
--prefix=/sdcc \
--datadir=/sdcc \
docdir=/sdcc/doc \
include_dir_suffix=include \
lib_dir_suffix=lib \
sdccconf_h_dir_separator=\\\\ \
--disable-device-lib --disable-ucsim
EXEEXTENSION = .exe
