HOSTNAME := $(shell if [ $(shell expr $(shell hostname) : '.*\.') != '0' ]; then expr $(shell hostname) : '\([^.]*\).'; else echo $(shell hostname); fi)
LOCAL_DIR=$(HOME)/local-$(HOSTNAME)

OS = $(shell uname)

isTTY=[ -t 1 -o -S /dev/stdin ]
WGET=if $(isTTY); then WGET_FLAGS='-P'; else WGET_FLAGS='-nv -P'; fi; wget $$WGET_FLAGS download

CFLAGS += -I$(HOME)/local-$(HOSTNAME)/include
CXXFLAGS += -I$(HOME)/local-$(HOSTNAME)/include
LDFLAGS += -L$(HOME)/local-$(HOSTNAME)/lib

ifeq ($(OS), Darwin)
  ifeq ($(HOSTNAME), mirror-doors)
    XCODE_ROOT = /Xcode2.5
  else
    XCODE_ROOT = /Developer
  endif
endif
