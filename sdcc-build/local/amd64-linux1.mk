# Opteron with Fedora Core release 3
MAKEJOBFLAGS = -j 2
TARGETOS = amd64-unknown-linux2.2
HOSTOS = amd64-unknown-linux2.2

# Enable the pic16 regression tests
REGTESTTARGETS += test-pic16

# The SDCC documentation package is built on this machine
# Configure the doc Makefile
SDCCCONFIGUREFLAGS = --enable-doc
# Run the doc Makefile
OPT_ENABLE_DOC = 1
