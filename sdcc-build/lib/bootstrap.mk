BOOTSTRAPLOG=$(TOPDIR)/build.log
BOOTSTRAPSSHMAILSERVER=shell1.sourceforge.net
BOOTSTRAPLIST=sdcc-devel@lists.sourceforge.net
BOOTSTRAPSUBJECT=Automated build output
BUILDDATE=$(shell date +%Y%m%d)
TARBALLNAME=$(TOPDIR)/build/sdcc-snapshot-$(TARGET)-$(BUILDDATE).tar.gz
SNAPSHOTDEST=shell1.sourceforge.net:/home/groups/s/sd/sdcc/htdocs/snapshots/$(TARGET)

update-bootstrap:
	cp -f sdcc-build-bootstrap.sh ..

# PENDING: Better naming
crontab-spawn: update-bootstrap logged-build generate-tarball upload-tarball send-build-mail kill-ssh-agent

logged-build:
	-$(MAKE) -s build > $(BOOTSTRAPLOG) 2>&1

generate-tarball:
	cd $(BUILDDIR); cd ..; tar czf $(TARBALLNAME) sdcc

upload-tarball:
	scp $(TARBALLNAME) $(SNAPSHOTDEST)

send-build-mail:
	cat $(BOOTSTRAPLOG) | ssh $(BOOTSTRAPSSHMAILSERVER) 'mail -s "$(BOOTSTRAPSUBJECT)" $(BOOTSTRAPLIST)'

kill-ssh-agent:
	ssh-agent -k
