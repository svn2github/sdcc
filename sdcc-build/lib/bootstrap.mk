# File to log all main make output to
BOOTSTRAPLOG=$(TOPDIR)/build.log
# Machine to ssh into to send the build result out via email
#BOOTSTRAPSSHMAILSERVER=smoke.csoft.net
BOOTSTRAPSSHMAILSERVER=shell1.sourceforge.net
# Address to send the filtered build output to
#BOOTSTRAPFILTEREDLIST=michaelh@juju.net.nz
#BOOTSTRAPFILTEREDLIST=bernhardheld@users.sourceforge.net
BOOTSTRAPFILTEREDLIST=sdcc-devel@lists.sourceforge.net
# Address to send the unfiltered build output to
#BOOTSTRAPLIST=michaelh@juju.net.nz
#BOOTSTRAPLIST=bernhardheld@users.sourceforge.net
BOOTSTRAPLIST=sdcc-buildlogs@lists.sourceforge.net
# Subject line to use in the build output email
BOOTSTRAPSUBJECT=Automated build output ($(TARGETOS))
# Stamp to append to the build name.
BUILDDATE=$(shell date +%Y%m%d)

# The file naming and output directories depend on whether this is a
# release or a snapshot build
ifeq ($(ISRELEASE),true)
# Format is staging/sdcc-version-target.tar.gz

# The tail part of the tar ball name
BUILDNAME=$(RELEASEVERSION)-$(TARGETOS)
# The root directory that the tarballs will go into
TARBALLBASE=staging
# The directory that the tarballs will finally go into
TARBALLDIR=$(STAGINGBASE)/$(TARBALLBASE)

else
# Format is snapshots/target/sdcc-target-date.tar.gz
BUILDNAME=snapshot-$(TARGETOS)-$(BUILDDATE)
TARBALLBASE=snapshots
TARBALLDIR=$(SNAPSHOTDIR)/$(TARGETOS)

endif

# Name of the tarball for this target
ifneq ($(CROSSCOMPILING), 1)
TARBALLNAME=$(TARBALLDIR)/sdcc-$(BUILDNAME).tar.gz
else
TARBALLNAME=$(TARBALLDIR)/sdcc-$(BUILDNAME).zip
endif

# Location to copy the tarball to
SNAPSHOTDEST=shell1.sourceforge.net:/home/groups/s/sd/sdcc/htdocs
# Host and path used for removing old versions
WEBHOST=shell1.sourceforge.net
WEBSNAPSHOTDIR=/home/groups/s/sd/sdcc/htdocs/$(TARBALLBASE)

# PENDING: Better naming
crontab-spawn: update-bootstrap archive-src-trees build-all-targets

# Update the bootstrap shell file that is used by cron to spawn a
# build
update-bootstrap:
	cp -f sdcc-build-bootstrap.sh ..

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
	for i in $(TARGETOS) $(OTHERTARGETS); do $(MAKE) $(MAKESILENTFLAG) per-target-release-build TARGETOS=$$i ISRELEASE=true 'CVSTAGFLAG=-r $(RELEASEVERSIONTAG)'; done

per-target-build: per-target-clean logged-build update-snapshots-dir send-build-mail

per-target-test-build: per-target-clean logged-build generate-tarball

per-target-release-build: per-target-clean logged-build copy-extra-docs generate-tarball

per-target-clean:
	rm -rf $(STAMPDIR)
	rm -rf $(SRCDIR)

logged-build:
	-$(MAKE) -k $(MAKESILENTFLAG) build 2>&1 | tee $(BOOTSTRAPLOG)

generate-tarball:
	mkdir -p `dirname $(TARBALLNAME)`
ifneq ($(CROSSCOMPILING), 1)
	-cd $(BUILDDIR)/..; tar czf $(TARBALLNAME) sdcc
else
	-find $(BUILDDIR) -name "*.txt" -exec /lib/ld-linux.so.2 --library-path $(HOME)/local/lib/ $(HOME)/local/bin/recode lat1..ibmpc {} \;
	-mv $(BUILDIR)/bin/sdcpp $(BUILDDIR)/bin/sdcpp.exe
	-cd $(BUILDDIR)/..; zip -9r $(TARBALLNAME) sdcc
endif

# Copies a few extra docs to the top level directory to give the user
# initial direction
copy-extra-docs:
	cd $(BUILDDIR); cp -f $(TOPDIR)/src/sdcc/doc/README.txt $(TOPDIR)/src/sdcc/doc/INSTALL.txt .

# Uploads and delete archive to save space on CF
upload-tarball: generate-tarball
	cd $(STAGINGBASE); rsync -rC -e ssh --size-only $(TARBALLBASE) $(SNAPSHOTDEST)
	rm $(STAGINGBASE)/$(TARBALLBASE)/*/*

update-snapshots-dir: remove-old-versions upload-tarball

# Removes all versions over seven days old.
remove-old-versions:
# over seven days old
#	ssh $(WEBHOST) 'cd $(WEBSNAPSHOTDIR); find . -mtime +7 -not -type d -exec rm {} \;'
# more than 7 files in dir
	ssh $(WEBHOST) 'cd $(WEBSNAPSHOTDIR); find * -type d -exec sh -c "cd {} ; ls -1t | sed 1,7d | xargs rm -f" \;'

# Sends email containing the results of the build, one filtered, one not.
send-build-mail:
	cat $(BOOTSTRAPLOG) | ssh $(BOOTSTRAPSSHMAILSERVER) 'mail -s "$(BOOTSTRAPSUBJECT)" $(BOOTSTRAPLIST)'
	-egrep -v -f $(TOPDIR)/support/error-filter.sh $(BOOTSTRAPLOG) > $(BOOTSTRAPLOG).filtered
	if egrep -qv '^ *$$' $(BOOTSTRAPLOG).filtered; then \
		cat $(BOOTSTRAPLOG).filtered | ssh $(BOOTSTRAPSSHMAILSERVER) 'mail -s "$(BOOTSTRAPSUBJECT)" $(BOOTSTRAPFILTEREDLIST)'; \
		fi
