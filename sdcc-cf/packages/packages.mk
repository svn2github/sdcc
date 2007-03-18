HOSTNAME := $(shell if [ $(shell expr $(shell hostname) : '.*\.') != '0' ]; then expr $(shell hostname) : '\([^.]*\).'; else echo $(shell hostname); fi)
LOCAL_DIR=$(HOME)/local-$(HOSTNAME)
SF_REPOSITORY=http://umn.dl.sourceforge.net

OS = $(shell uname)

CFLAGS += -I$(HOME)/local-$(HOSTNAME)/include
CXXFLAGS += -I$(HOME)/local-$(HOSTNAME)/include
LDFLAGS += -L$(HOME)/local-$(HOSTNAME)/lib

ifeq ($(OS), Darwin)
  CFLAGS += -I/sw/include
  CXXFLAGS += -I/sw/include
  LDFLAGS += -L/sw/lib
endif
