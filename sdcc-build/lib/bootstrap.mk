BOOTSTRAPLOG=$(TOPDIR)/build.log
BOOTSTRAPSSHMAILSERVER=shell1.sourceforge.net
BOOTSTRAPLIST=michaelh@juju.net.nz
BOOTSTRAPSUBJECT=Automated build output

update-bootstrap:
	cp -f sdcc-build-bootstrap.sh ..

# PENDING: Better naming
crontab-spawn:
	-$(MAKE) -s fail > $(BOOTSTRAPLOG) 2>&1
	cat $(BOOTSTRAPLOG) | ssh $(BOOTSTRAPSSHMAILSERVER) 'mail -s "$(BOOTSTRAPSUBJECT)" $(BOOTSTRAPLIST)'
	ssh-agent -k
