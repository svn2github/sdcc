# Rules to include local settings
USERCONFIG = local/$(HOSTNAME)-$(USER).mk
HOSTCONFIG = local/$(HOSTNAME).mk

ifneq ($(wildcard $(HOSTCONFIG)), )
include $(HOSTCONFIG)
endif

ifneq ($(wildcard $(USERCONFIG)), )
include $(USERCONFIG)
endif

HOSTTARGETCONFIG = local/$(HOSTNAME)-$(TARGETOS).mk

ifneq ($(wildcard $(HOSTTARGETCONFIG)), )
include $(HOSTTARGETCONFIG)
endif
