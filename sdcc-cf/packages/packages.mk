HOSTNAME := $(shell if [ $(shell expr $(shell hostname) : '.*\.') != '0' ]; then expr $(shell hostname) : '\([^.]*\).'; else echo $(shell hostname); fi)
LOCAL_DIR=$(HOME)/local-$(HOSTNAME)
SF_REPOSITORY=http://umn.dl.sourceforge.net
