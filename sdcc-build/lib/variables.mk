# List of all source trees that need to be fetched either locally or from cvs
SRCTREES += 
# Target to build for.
TARGETOS = i386-unknown-linux2.2
# Local host type.
HOSTOS = i386-unknown-linux2.2
# By default compile for the host.
TOOLSPREFIX = 
# Path to the makensis binary
NSISBIN = $(HOME)/local/bin
# Extract the host name without domain to $(HOSTNAME)
HOSTNAME = $(shell if [ $(shell expr $(shell hostname) : '.*\.') != '0' ]; then expr $(shell hostname) : '\([^.]*\).'; else echo $(shell hostname); fi)
# Stamp to append to the build name.
BUILDDATE=$(shell date +%Y%m%d)
# Get revision from sdcc/ChangeLog to append to the build name
SDCCREVISION=$(shell grep ^\$$Revision src/sdcc/ChangeLog | awk '{ print $$2 }')

TOPDIR := $(shell /bin/pwd)

# Directory that all of the soure trees get copied into
SRCDIR = src
ORIGDIR = orig
BUILDDIR = $(TOPDIR)/build/$(TARGETOS)/sdcc
BINDIR= $(BUILDDIR)/bin
NOISELOG = $(STAGINGBASE)/build-noise.$(TARGETOS).log
STAGINGBASE = $(TOPDIR)/..
SNAPSHOTDIR = $(STAGINGBASE)/snapshots
# Start of the CVS repository line, used to set the access method (pserver,
# ext, ...) and username.  Can be overriden in your local.mk
CVSACCESS = :ext:sdcc-builder

CVSFLAGS += -Q
SVNFLAGS +=
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
