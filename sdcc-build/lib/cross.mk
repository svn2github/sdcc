ifeq ($(TARGETCC),)
  TARGETCC = $(TOOLSPREFIX)gcc
endif
ifeq ($(TARGETCXX),)
  TARGETCXX = $(TOOLSPREFIX)g++
endif
ifeq ($(TARGETRANLIB),)
  TARGETRANLIB = $(TOOLSPREFIX)ranlib
endif
ifeq ($(TARGETSTRIP),)
  TARGETSTRIP = $(TOOLSPREFIX)strip
endif
