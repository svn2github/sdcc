# Rules to include local settings

# Path to the directory containing local machine makefiles (<hostname>.mk)
# $(HOME)/build/sdcc-build/local is used if the path doesn't exist
ifneq ($(shell test -d $(LOCAL_MK) && echo 1),1)
  LOCAL_MK = local
endif

USERCONFIG = $(LOCAL_MK)/$(HOSTNAME)-$(USER).mk
HOSTCONFIG = $(LOCAL_MK)/$(HOSTNAME).mk

ifneq ($(wildcard $(HOSTCONFIG)), )
include $(HOSTCONFIG)
endif

ifneq ($(wildcard $(USERCONFIG)), )
include $(USERCONFIG)
endif

HOSTTARGETCONFIG = $(LOCAL_MK)/$(HOSTNAME)-$(TARGETOS).mk

ifneq ($(wildcard $(HOSTTARGETCONFIG)), )
include $(HOSTTARGETCONFIG)
endif
