# Dual processor
CROSSCOMPILING = 1
TOOLSPREFIX = $(HOME)/local/cross-tools/bin/i386-mingw32msvc-
SDCCCONFIGUREFLAGS = \
--prefix=/sdcc \
--datadir=/sdcc \
docdir=/sdcc/doc \
include_dir_suffix=include \
lib_dir_suffix=lib \
sdccconf_h_dir_separator=\\\\ \
--disable-device-lib-build --disable-ucsim
EXEEXTENSION = .exe
SDCCINSTALLFLAGS = docdir=$(BUILDDIR)/doc
