ifeq ($(TARGETCC),)
  TARGETCC = $(TOOLSPREFIX)gcc
endif
ifeq ($(TARGETCXX),)
  TARGETCXX = $(TOOLSPREFIX)g++
endif
ifeq ($(TARGETAR),)
  TARGETAR = $(TOOLSPREFIX)ar
endif
ifeq ($(TARGETRANLIB),)
  TARGETRANLIB = $(TOOLSPREFIX)ranlib
endif
ifeq ($(TARGETSTRIP),)
  TARGETSTRIP = $(TOOLSPREFIX)strip
endif
