# File to log all main make output to
BOOTSTRAPLOG=$(STAGINGBASE)/build.$(TARGETOS).log
# Machine to ssh into to send the build result out via email
#BOOTSTRAPSSHMAILSERVER=smoke.csoft.net
BOOTSTRAPSSHMAILSERVER=shell1.sourceforge.net
# Address to send the filtered build output to
#BOOTSTRAPFILTEREDLIST=michaelh@juju.net.nz
#BOOTSTRAPFILTEREDLIST=sdcc-devel@lists.sourceforge.net
BOOTSTRAPFILTEREDLIST=sdcc-devel@lists.sourceforge.net
# Admin address to send the filtered build output to
#BOOTSTRAPFILTEREDLISTADMIN=bernhardheld@users.sourceforge.net
BOOTSTRAPFILTEREDLISTADMIN=epetrich@users.sourceforge.net
# Address to send the unfiltered build output to
#BOOTSTRAPLIST=michaelh@juju.net.nz
#BOOTSTRAPLIST=bernhardheld@users.sourceforge.net
BOOTSTRAPLIST=sdcc-buildlogs@lists.sourceforge.net
# Subject line to use in the build output email
BOOTSTRAPSUBJECT=Automated build output ($(TARGETOS))

REGTESTBASE = regression_test_results

# The file naming and output directories depend on whether this is a
# release or a snapshot build
ifeq ($(ISRELEASE),true)
# Format is staging/sdcc-version-target.tar.bz2

# The tail part of the tar ball name
BUILDNAME=$(RELEASEVERSION)-$(TARGETOS)
# The root directory that the tarballs will go into
TARBALLBASE=staging
# The directory that the tarballs will finally go into
TARBALLDIR=$(STAGINGBASE)/$(TARBALLBASE)

else
# Format is snapshots/target/sdcc-target-date-revision.tar.bz2
BUILDNAME=snapshot-$(TARGETOS)-$(SNAPSHOTID)
TARBALLBASE=snapshots
TARBALLDIR=$(SNAPSHOTDIR)/$(TARGETOS)

endif

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

generate-packages: generate-tarball generate-setup

generate-setup:
ifeq ($(CROSSCOMPILING), 1)
	mkdir -p $(dir $(SETUPNAME))
	cp $(ORIGDIR)/sdcc/COPYING $(BUILDDIR)/sdcc/COPYING.TXT; unix2dos $(BUILDDIR)/sdcc/COPYING.TXT
	cp $(ORIGDIR)/sdcc/support/scripts/sdcc.nsi $(BUILDDIR)/sdcc
	cp $(ORIGDIR)/sdcc/support/scripts/sdcc.ico $(BUILDDIR)/sdcc
	-cd $(BUILDDIR)/sdcc; $(NSISBIN)/makensis sdcc.nsi;
	mv $(BUILDDIR)/sdcc/setup.exe $(SETUPNAME)
endif

generate-tarball:
	mkdir -p `dirname $(TARBALLNAME)`
ifneq ($(CROSSCOMPILING), 1)
	-cd $(BUILDDIR)/..; tar cjf $(TARBALLNAME) sdcc 
else
# 2004-10-10 borutr: Windows use Latin1 (actually CP1252) - no encoding conversion is needed,
# so the next line is commented out
#	-find $(BUILDDIR) \( -name "*.txt" -or -name "*.TXT" \) -exec recode lat1..ibmpc {} \;
	-cd $(BUILDDIR); zip -9r $(TARBALLNAME) sdcc
endif

# Copies a few extra docs to the top level directory to give the user
# initial direction
copy-extra-docs:
	cd $(BUILDDIR); cp -f $(TOPDIR)/src/sdcc/doc/README.txt $(TOPDIR)/src/sdcc/doc/INSTALL.txt .

# Uploads and delete archive to save space on CF
upload-packages: generate-tarball generate-packages do-upload

update-snapshots-dir: upload-packages remove-old-versions

# Sends email containing the results of the build, one filtered, one not.
send-build-mail:
	# 2003-06-03 Bernhard: nobody reads the BOOTSTRAPLIST, so let's save SF's resources by not sending the logs.
	# cat $(BOOTSTRAPLOG) | ssh $(BOOTSTRAPSSHMAILSERVER) 'mail -s "$(BOOTSTRAPSUBJECT)" $(BOOTSTRAPLIST)'
	-egrep -v -f $(TOPDIR)/support/error-filter.sh $(BOOTSTRAPLOG) > $(BOOTSTRAPLOG).filtered
	# If there's something in the log
	#	If there's anything else than summaries (e.g. error messages)
	#		Send it to the list
	#	Else
	#		Send it to the adim
	if egrep -v '^ *$$' $(BOOTSTRAPLOG).filtered > /dev/null; then \
		if egrep -v '^Summary for ' $(BOOTSTRAPLOG).filtered > /dev/null; then \
			cat $(BOOTSTRAPLOG).filtered | ssh $(BOOTSTRAPSSHMAILSERVER) 'mail -s "$(BOOTSTRAPSUBJECT)" $(BOOTSTRAPFILTEREDLISTADMIN)'; \
		else \
			cat $(BOOTSTRAPLOG).filtered | ssh $(BOOTSTRAPSSHMAILSERVER) 'mail -s "$(BOOTSTRAPSUBJECT)" $(BOOTSTRAPFILTEREDLISTADMIN)'; \
		fi \
	fi
