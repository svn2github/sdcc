MAKEJOBFLAGS =
TARGETOS = i386-unknown-linux2.4
HOSTOS = i386-unknown-linux2.4

# cross-tools are installed
OTHERTARGETS = i586-mingw32msvc

# The SDCC documentation package is built on this machine
# Configure the doc Makefile
SDCCCONFIGUREFLAGS = --enable-doc
# Run the doc Makefile
OPT_ENABLE_DOC = 1

