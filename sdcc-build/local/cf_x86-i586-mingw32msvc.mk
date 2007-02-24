MAKEJOBFLAGS =
CROSSCOMPILING = 1
TOOLSPREFIX = /usr/bin/i386-mingw32-
PREFIX = /sdcc
SDCCCONFIGUREFLAGS = \
--prefix=$(PREFIX) \
--datarootdir=/sdcc \
docdir=$${datarootdir}/doc \
include_dir_suffix=include \
lib_dir_suffix=lib \
sdccconf_h_dir_separator=\\\\ \
--disable-device-lib --disable-ucsim
EXEEXTENSION = .exe
