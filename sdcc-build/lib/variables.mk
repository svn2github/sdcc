# List of all source trees that need to be fetched either locally or from Subversion
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
HOSTNAME := $(shell if [ $(shell expr $(shell hostname) : '.*\.') != '0' ]; then expr $(shell hostname) : '\([^.]*\).'; else echo $(shell hostname); fi)
# Get build date
BUILDDATE := $(shell date +%Y%m%d)
# Current revision in Subversion
SVNREVISION := $(shell svn info https://svn.sourceforge.net/svnroot/sdcc | awk '/^Revision:/ { print $$2 }')
## Get revision from sdcc/ChangeLog to append to the build name
#SDCCREVISION = $(shell awk '/^\$$Revision:/ { print $$2 }' $(ORIGDIR)/sdcc/ChangeLog)
# Get current revision from Subversion to append to the build name (temporary workaround)
SDCCREVISION := $(shell svn info https://svn.sourceforge.net/svnroot/sdcc | awk '/^Revision:/ { print $$2 }')
# Stamp to append to the build name
SNAPSHOTID = $(BUILDDATE)-$(SDCCREVISION)

TOPDIR := $(shell /bin/pwd)

# Directory that all of the soure trees get copied into
#SRCDIR = $(TOPDIR)/src
SRCDIR = src
#ORIGDIR = ~/build/sdcc-build/orig
ORIGDIR = orig
BUILDDIR = $(TOPDIR)/build/$(TARGETOS)/sdcc
BINDIR = $(BUILDDIR)/bin
NOISELOG = $(STAGINGBASE)/build-noise.$(TARGETOS).log
STAGINGBASE = $(TOPDIR)/..
SNAPSHOTDIR = $(STAGINGBASE)/snapshots
# Start of the CVS repository line, used to set the access method (pserver,
# ext, ...) and username.  Can be overriden in your local.mk
CVSACCESS = :ext:sdcc-builder

CVSFLAGS += -Q
SVNFLAGS += --force
#STAMPDIR = $(ORIGDIR)/../stamps
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
