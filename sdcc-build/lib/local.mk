# Rules to include local settings
USERCONFIG = local/$(HOSTNAME)-$(USER).mk

ifneq ($(wildcard $(USERCONFIG)), )
include $(USERCONFIG)
endif


