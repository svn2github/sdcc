BUGSMAILSERVER=shell1.sourceforge.net
BUGSLIST=sdcc-buildlogs@lists.sourceforge.net
BUGSSUBJECT=Open bugs summary

bugs-send-summary: $(TOPDIR)/bugs.txt
	cat $(TOPDIR)/support/bug-summary-header.txt $(TOPDIR)/bugs.txt | \
		ssh $(BUGSMAILSERVER) 'mail -s "$(BUGSSUBJECT)" $(BUGSLIST)'

$(TOPDIR)/bugs.txt:
	perl $(TOPDIR)/support/bug-summary.pl 599 > $(TOPDIR)/bugs.txt

