# Address to send the filtered build output to
BOOTSTRAPFILTEREDLIST = sdcc-devel@lists.sourceforge.net

# Admin address to send the filtered build output to
BOOTSTRAPFILTEREDLISTADMIN = epetrich@users.sourceforge.net

# Address to send the unfiltered build output to
BOOTSTRAPLIST = sdcc-buildlogs@lists.sourceforge.net

# Subject line to use in the build output email
BOOTSTRAPSUBJECT = Automated build output ($(TARGETOS))

.PHONY: send-build-mail

# Sends email containing the results of the build, one filtered, one not.
send-build-mail:
	## 2003-06-03 Bernhard: nobody reads the BOOTSTRAPLIST, so let's save SF's resources by not sending the logs.
	## cat $(BOOTSTRAPLOG) | ssh $(BOOTSTRAPSSHMAILSERVER) 'mail -s "$(BOOTSTRAPSUBJECT)" $(BOOTSTRAPLIST)'
	#-egrep -v -f $(TOPDIR)/support/error-filter.sh $(BOOTSTRAPLOG) > $(BOOTSTRAPLOG).filtered
	## If there's something in the log
	##   If there's anything else than summaries (e.g. error messages)
	##     Send it to the list
	##   Else
	##     Send it to the adim
	#if test -n "$(BOOTSTRAPSSHMAILSERVER)"; then \
	#  if egrep -v '^ *$$' $(BOOTSTRAPLOG).filtered > /dev/null; then \
	#    if egrep -v '^Summary for ' $(BOOTSTRAPLOG).filtered > /dev/null; then \
	#      cat $(BOOTSTRAPLOG).filtered | ssh $(BOOTSTRAPSSHMAILSERVER) 'mail -s "$(BOOTSTRAPSUBJECT)" $(BOOTSTRAPFILTEREDLISTADMIN)'; \
	#    else \
	#      cat $(BOOTSTRAPLOG).filtered | ssh $(BOOTSTRAPSSHMAILSERVER) 'mail -s "$(BOOTSTRAPSUBJECT)" $(BOOTSTRAPFILTEREDLISTADMIN)'; \
	#    fi \
	#  fi \
	#fi
