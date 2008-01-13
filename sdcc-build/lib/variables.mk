# List of all source trees that need to be fetched either locally or from Subversion
SRCTREES +=
# Target to build for.
TARGETOS = unknown-unknown-unknown
# Target platform name equals to target OS name by default
TARGET_PLATFORM = $(TARGETOS)
# Local host type.
HOSTOS = unknown-unknown-unknown
# By default compile for the host.
TOOLSPREFIX =
# Extract the host name without domain to $(HOSTNAME)
HOSTNAME := $(shell if [ $(shell expr $(shell hostname) : '.*\.') != '0' ]; then expr $(shell hostname) : '\([^.]*\).'; else echo $(shell hostname); fi)
# Path to the makensis binary
NSISBIN = $(HOME)/local-$(HOSTNAME)/bin
# Get build date
BUILDDATE := $(shell date +%Y%m%d)
# Stamp to append to the build name
SNAPSHOTID = $(BUILDDATE)-$(SDCC_REVISION)

# Path to the directory containing local machine makefiles (<hosatname>.mk)
# $(HOME)/build/sdcc-build/local is used if the path doesn't exist
LOCAL_MK = $(HOME)/.sdcc_builder/local

# WEB server host, user and path
WEBHOST = shell1.sourceforge.net
WEBUSER = sdcc-builder
WEBHTDOCSDIR = /home/groups/s/sd/sdcc/htdocs/

# Machine to ssh into to send the build result out via email
BOOTSTRAPSSHMAILSERVER =

# default prefix
PREFIX = /usr/local
# default host prefix if cross compiling
HOSTPREFIX = /usr/local

TOPDIR := $(shell /bin/pwd)

# Directory that all of the soure trees get copied into
SRCDIR = $(TOPDIR)/src
ORIGDIR = $(HOME)/build/sdcc-build/orig
BUILDDIR = $(TOPDIR)/build/$(TARGET_PLATFORM)/sdcc
BINDIR = $(BUILDDIR)/bin
NOISELOG = $(STAGINGBASE)/build-noise.$(TARGET_PLATFORM).log
STAGINGBASE = $(TOPDIR)/..
HTDOCSDIR = $(STAGINGBASE)/htdocs
SNAPSHOTDIR = $(HTDOCSDIR)/snapshots

# Start of the CVS repository line, used to set the access method (pserver,
# ext, ...) and username.  Can be overriden in your local.mk
CVSACCESS = :ext:sdcc-builder
# Name of the machine used for fetching svn tree; empty for the local machine
SVNSERVER =

# Regression test targets
REGTESTTARGETS = test-host test-mcs51-small test-mcs51-large test-mcs51-stack-auto test-ds390 test-hc08 test-ucz80
# Directory for regression test log file
REGTESTDIR = $(HTDOCSDIR)/regression_test_results/$(TARGET_PLATFORM)
# Regression test log file
REGTESTLOG = $(REGTESTDIR)/regression-test-$(TARGET_PLATFORM)-$(SNAPSHOTID).log

# Directory for regression test log file
CHLOGDIR = $(HTDOCSDIR)/changelog_heads
# Regression test log file
CHLOGTXT = $(CHLOGDIR)/changelog-head-$(SDCC_REVISION).txt

CVSFLAGS += -Q
SVNFLAGS += --force
STAMPDIR = $(ORIGDIR)/../stamps
RSYNCFLAGS = -C -r
# Passed on to Makes to make them silent. Can override.
MAKESILENTFLAG = -s

# The file naming and output directories depend on whether this is a
# release or a snapshot build
ifeq ($(ISRELEASE),true)
# Format is staging/sdcc-version-target.tar.bz2
# The tail part of the tar ball name
BUILDNAME = $(RELEASEVERSION)-$(TARGET_PLATFORM)
# The root directory that the tarballs will go into
TARBALLBASE = staging
# The directory that the tarballs will finally go into
TARBALLDIR = $(STAGINGBASE)/$(TARBALLBASE)
else
# Format is snapshots/target/sdcc-target-date-revision.tar.bz2
BUILDNAME = snapshot-$(TARGET_PLATFORM)-$(SNAPSHOTID)
TARBALLBASE = snapshots
TARBALLDIR = $(SNAPSHOTDIR)/$(TARGET_PLATFORM)
endif

$(STAMPDIR):
	mkdir -p $(STAMPDIR)

$(ORIGDIR):
	mkdir -p $(ORIGDIR)

$(SRCDIR):
	mkdir -p $(SRCDIR)

dirs: $(STAMPDIR) $(ORIGDIR) $(SRCDIR)
