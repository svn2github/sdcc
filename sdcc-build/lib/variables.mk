# List of all source trees that need to be fetched either locally or from Subversion
SRCTREES +=
# Top build directory
TOPDIR := $(shell /bin/pwd)
# Local host type.
HOSTOS := $(shell $(TOPDIR)/support/config.guess)
# Target to build for.
TARGETOS = $(HOSTOS)
# Target platform name equals to target OS name by default
TARGET_PLATFORM = $(TARGETOS)
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

# DCF server host, user and path
# cf-x86.ivorytower.norman.ok.us
DCFHOST = 66.142.207.42
DCFPORT = 22
DCFUSER = $(HOSTNAME)
DCFHTDOCSDIR = /home/$(HOSTNAME)/htdocs/

# Machine to ssh into to send the build result out via email
BOOTSTRAPSSHMAILSERVER =

# default prefix
PREFIX = /usr/local
# default host prefix if cross compiling
HOSTPREFIX = /usr/local

# Directory that all of the soure trees get copied into
SRCDIR = $(TOPDIR)/$(TARGET_PLATFORM).build
ORIGDIR = $(HOME)/build/sdcc-build/orig
BUILDDIR = $(TOPDIR)/build/$(TARGET_PLATFORM)/sdcc
BINDIR = $(BUILDDIR)/bin
STAGINGBASE = $(TOPDIR)/..
HTDOCSDIR = $(STAGINGBASE)/htdocs
SNAPSHOTDIR = $(HTDOCSDIR)/snapshots

# Name of the machine used for fetching svn tree; empty for the local machine
SVNSERVER =

# Subversion repository root url
SVN_ROOT = svn://svn.code.sf.net/p/sdcc/code

# Regression test targets. To help reduce the load on the slower systems of the DCF, the
# test targets are broken up into three categories:
#  REGTESTTARGETS_1_0: These will always be tested
#  REGTESTTARGETS_2_0: These will be tested on even days
#  REGTESTTARGETS_2_1: These will be tested on odd days
# TODO: Replace test-ucr3ka by test-ucz80-resiy when the r3ka port gets dropped.
REGTESTTARGETS_1_0 = test-ds390
REGTESTTARGETS_2_0 = test-mcs51-medium test-mcs51-large test-mcs51-stack-auto test-hc08 test-ucz80 test-ucgbz80 test-ucr2k test-stm8-large
REGTESTTARGETS_2_1 = test-mcs51-small test-mcs51-huge test-mcs51-large-stack-auto test-s08 test-ucz180 test-tlcs90 test-ucr3ka test-stm8 test-ucz80-resiy

DAYODD = $(shell date +%j | awk '{print $$0%2}')
ifeq ($(strip $(DAYODD)),0)
CROSSREGTESTTARGETS = $(REGTESTTARGETS_1_0) $(REGTESTTARGETS_2_1)
else
CROSSREGTESTTARGETS = $(REGTESTTARGETS_1_0) $(REGTESTTARGETS_2_0)
endif
REGTESTTARGETS = test-host $(CROSSREGTESTTARGETS)
# Directory for regression test log file
REGTESTDIR = $(HTDOCSDIR)/regression_test_results/$(TARGET_PLATFORM)
# Regression test log file
REGTESTLOG = $(REGTESTDIR)/regression-test-$(TARGET_PLATFORM)-$(SNAPSHOTID).log

# Directory for regression test log file
CHLOGDIR = $(HTDOCSDIR)/changelog_heads
# Regression test log file
CHLOGTXT = $(CHLOGDIR)/changelog-head-$(SDCC_REVISION).txt

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

# dos utils
UNIX2DOS := $(shell if test -x /usr/bin/unix2dos -o -x $(HOME)/local-$(HOSTNAME)/bin/unix2dos; then echo unix2dos; else echo todos; fi)

$(STAMPDIR):
	mkdir -p $(STAMPDIR)

$(ORIGDIR):
	mkdir -p $(ORIGDIR)

$(SRCDIR):
	mkdir -p $(SRCDIR)

dirs: $(STAMPDIR) $(ORIGDIR) $(SRCDIR)
