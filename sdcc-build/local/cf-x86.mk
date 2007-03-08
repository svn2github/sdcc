# Generate native 64 bit amd64 Linux executables on
# AMD Sempron with Fedora Core release 6

# Spawn 2 make proceses
MAKEJOBFLAGS = -j 2

TARGETOS = amd64-unknown-linux2.5
HOSTOS = amd64-unknown-linux2.5

# Enable the pic16 regression tests
REGTESTTARGETS += test-pic16

# cross-tools are installed
OTHERTARGETS = i586-mingw32msvc i386-unknown-linux2.5

# The SDCC documentation package is built on this machine
# Configure the doc Makefile
SDCCCONFIGUREFLAGS = --enable-doc
# Run the doc Makefile
OPT_ENABLE_DOC = 1
