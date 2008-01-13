# File to log all main make output to
BOOTSTRAPLOG=$(STAGINGBASE)/build.$(TARGETOS).log

REGTESTBASE = regression_test_results

# Name of the tarball for this target
ifneq ($(CROSSCOMPILING), 1)
TARBALLNAME=$(TARBALLDIR)/sdcc-$(BUILDNAME).tar.bz2
else
TARBALLNAME=$(TARBALLDIR)/sdcc-$(BUILDNAME).zip
SETUPNAME=$(TARBALLDIR)-setup/sdcc-$(SNAPSHOTID)-setup.exe
endif

# PENDING: Better naming
crontab-spawn: update-bootstrap build-all-targets

# Update the bootstrap shell file that is used by cron to spawn a
# build
update-bootstrap:
	cp -f sdcc-build-bootstrap.sh ..
	chmod 744 ../sdcc-build-bootstrap.sh

# Does a test build for each target which does everything but send the
# emails and upload the tarballs
test-all-targets:
	for i in $(TARGETOS) $(OTHERTARGETS); do $(MAKE) $(MAKESILENTFLAG) per-target-test-build TARGETOS=$$i; done

# Builds for each target, including sending the results out in an
# email and updating the snapshots directory
build-all-targets:
	for i in $(TARGETOS) $(OTHERTARGETS); do $(MAKE) $(MAKESILENTFLAG) per-target-build TARGETOS=$$i; done

# Does a release build of each target by checking out from a label and
# building for each target
release-build:
	for i in $(TARGETOS) $(OTHERTARGETS); do $(MAKE) $(MAKESILENTFLAG) per-target-release-build TARGETOS=$$i ISRELEASE=true 'SVNTAG=$(RELEASEVERSIONTAG)'; done

per-target-build: per-target-clean logged-build update-snapshots-dir send-build-mail

per-target-test-build: per-target-clean logged-build generate-packages

per-target-release-build: per-target-clean logged-build copy-extra-docs generate-packages

per-target-clean:
	rm -rf $(SRCDIR)

logged-build:
	echo "--- Building $(TARGETOS) ---" | tee $(BOOTSTRAPLOG)
	-$(MAKE) -k $(MAKESILENTFLAG) build 2>&1 | tee -a $(BOOTSTRAPLOG)

generate-packages: copy-extra-bins generate-tarball generate-setup

copy-extra-bins:
ifeq ($(CROSSCOMPILING), 1)
	cp $(HOME)/local-$(HOSTNAME)/cross-tools/i586-mingw32msvc/dll/readline5.dll $(BUILDDIR)$(PREFIX)/bin
endif

generate-tarball:
	mkdir -p `dirname $(TARBALLNAME)`
ifneq ($(CROSSCOMPILING), 1)
	-cd $(BUILDDIR)$(PREFIX)/..; \
	if test "$(shell basename $(BUILDDIR)$(PREFIX))" != sdcc; then \
	  mv $(shell basename $(BUILDDIR)$(PREFIX)) sdcc; \
	fi; \
	tar cf - sdcc | bzip2 -c - > $(TARBALLNAME); \
	if test "$(shell basename $(BUILDDIR)$(PREFIX))" != sdcc; then \
	  mv sdcc $(shell basename $(BUILDDIR)$(PREFIX)); \
	fi
else
# 2004-10-10 borutr: Windows use Latin1 (actually CP1252) - no encoding conversion is needed,
# so the next line is commented out
#	-find $(BUILDDIR) \( -name "*.txt" -or -name "*.TXT" \) -exec recode lat1..ibmpc {} \;
	-cd $(BUILDDIR); zip -9r $(TARBALLNAME) sdcc
endif

generate-setup:
ifeq ($(CROSSCOMPILING), 1)
	mkdir -p $(dir $(SETUPNAME))
	cp $(ORIGDIR)/sdcc/COPYING $(BUILDDIR)$(PREFIX)/COPYING.TXT; unix2dos $(BUILDDIR)$(PREFIX)/COPYING.TXT
	cp $(ORIGDIR)/sdcc/support/scripts/sdcc.nsi $(BUILDDIR)$(PREFIX)
	cp $(ORIGDIR)/sdcc/support/scripts/sdcc.ico $(BUILDDIR)$(PREFIX)
	-cd $(BUILDDIR)$(PREFIX); \
	  $(NSISBIN)/makensis -DVER_MAJOR=$(SDCC_VER_MAJOR) -DVER_MINOR=$(SDCC_VER_MINOR) -DVER_REVISION=$(SDCC_VER_DEVEL) -DVER_BUILD=$(SDCC_REVISION) sdcc.nsi;
	mv $(BUILDDIR)$(PREFIX)/setup.exe $(SETUPNAME)
endif

# Copies a few extra docs to the top level directory to give the user
# initial direction
copy-extra-docs:
	cp -f $(SRCDIR)/sdcc/doc/README.txt $(SRCDIR)/sdcc/doc/INSTALL.txt $(BUILDDIR)

update-snapshots-dir: generate-tarball generate-packages
