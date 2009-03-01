# extract version info from various sources:
# SDCC_VER_MAJOR, SDCC_VER_MINOR, SDCC_VER_DEVEL from .version
# SDCC_REVISION is svn revision from ChangeLog

SDCC_VER_MAJOR = $(shell awk 'BEGIN { FS="."; getline; print $$1 }' $(ORIGDIR)/sdcc/.version)
SDCC_VER_MINOR = $(shell echo $(VERSION) | awk 'BEGIN { FS="."; getline; print $$2 }' $(ORIGDIR)/sdcc/.version)
SDCC_VER_DEVEL = $(shell echo $(VERSION) | awk 'BEGIN { FS="."; getline; print $$3 }' $(ORIGDIR)/sdcc/.version)
SDCC_REVISION = $(shell awk '/^\$$Revision:/ { print $$2 }' $(ORIGDIR)/sdcc/ChangeLog)
