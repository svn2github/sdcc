# List of all source trees that need to be fetched either locally or from cvs
SRCTREES += 
# Target to build for.
TARGETOS = i386-unknown-linux2.2
# Local host type.
HOSTOS = i386-unknown-linux2.2
# By default compile for the host.
TOOLSPREFIX = 

TOPDIR := $(shell /bin/pwd)

# Directory that all of the soure trees get copied into
SRCDIR = src
ORIGDIR = orig
BUILDDIR = $(TOPDIR)/build/$(TARGETOS)/sdcc
BINDIR= $(BUILDDIR)/bin
NOISELOG = $(TOPDIR)/build-noise.$(TARGETOS).log
STAGINGBASE = $(TOPDIR)/..
SNAPSHOTDIR = $(STAGINGBASE)/snapshots

CVSFLAGS += -Q
STAMPDIR = stamps
RSYNCFLAGS = -C -r
# Passed on to Makes to make them silent.  Can override.
MAKESILENTFLAG = -s

$(STAMPDIR):
	mkdir -p $(STAMPDIR)

$(ORIGDIR):
	mkdir -p $(ORIGDIR)

$(SRCDIR):
	mkdir -p $(SRCDIR)

dirs: $(STAMPDIR) $(ORIGDIR) $(SRCDIR)
