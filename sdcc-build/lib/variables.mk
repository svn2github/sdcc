# List of all source trees that need to be fetched either locally or from Subversion
SRCTREES +=
# Target to build for.
TARGETOS = unknown-unknown-unknown
# Local host type.
HOSTOS = unknown-unknown-unknown
# By default compile for the host.
TOOLSPREFIX =
# Path to the makensis binary
NSISBIN = $(HOME)/local/bin
# Extract the host name without domain to $(HOSTNAME)
HOSTNAME := $(shell if [ $(shell expr $(shell hostname) : '.*\.') != '0' ]; then expr $(shell hostname) : '\([^.]*\).'; else echo $(shell hostname); fi)
# Get build date
BUILDDATE := $(shell date +%Y%m%d)
# Get revision from sdcc/ChangeLog to append to the build name
SDCCREVISION = $(shell awk '/^\$$Revision:/ { print $$2 }' $(ORIGDIR)/sdcc/ChangeLog)
# Stamp to append to the build name
SNAPSHOTID = $(BUILDDATE)-$(SDCCREVISION)

# default prefix
PREFIX = /usr/local
# default host prefix if cross compiling
HOSTPREFIX = /usr/local

TOPDIR := $(shell /bin/pwd)

# Directory that all of the soure trees get copied into
SRCDIR = $(TOPDIR)/src
ORIGDIR = $(HOME)/build/sdcc-build/orig
BUILDDIR = $(TOPDIR)/build/$(TARGETOS)/sdcc
BINDIR = $(BUILDDIR)/bin
NOISELOG = $(STAGINGBASE)/build-noise.$(TARGETOS).log
STAGINGBASE = $(TOPDIR)/..
HTDOCSDIR = $(STAGINGBASE)/htdocs
SNAPSHOTDIR = $(HTDOCSDIR)/snapshots

# Start of the CVS repository line, used to set the access method (pserver,
# ext, ...) and username.  Can be overriden in your local.mk
CVSACCESS = :ext:sdcc-builder
# Subversion server, accessed by ssh
SVNSERVER = sdcc-builder@shell.cf.sourceforge.net

# Regression test targets
REGTESTTARGETS = test-host test-ucz80 test-mcs51 test-mcs51-stack-auto test-mcs51-large test-ds390 test-hc08
# Directory for regression test log file
REGTESTDIR = $(HTDOCSDIR)/regression_test_results/$(TARGETOS)
# Regression test log file
REGTESTLOG = $(REGTESTDIR)/regression-test-$(TARGETOS)-$(SNAPSHOTID).log

# Directory for regression test log file
CHLOGDIR = $(HTDOCSDIR)/changelog_heads
# Regression test log file
CHLOGTXT = $(CHLOGDIR)/changelog-head-$(SDCCREVISION).txt

CVSFLAGS += -Q
SVNFLAGS += --force
STAMPDIR = $(ORIGDIR)/../stamps
RSYNCFLAGS = -C -r
# Passed on to Makes to make them silent. Can override.
MAKESILENTFLAG = -s

$(STAMPDIR):
	mkdir -p $(STAMPDIR)

$(ORIGDIR):
	mkdir -p $(ORIGDIR)

$(SRCDIR):
	mkdir -p $(SRCDIR)

dirs: $(STAMPDIR) $(ORIGDIR) $(SRCDIR)
