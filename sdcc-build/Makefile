# Top level Makefile for sdcc-build.
# See README, and try 'make help'

all: build

include lib/variables.mk
include lib/local.mk
include lib/ports.mk

include components/sdcc.mk

include lib/fetch.mk
include lib/clean.mk
include lib/install.mk
include lib/help.mk

build: dirs fetch-build-trees sdcc

test-integrity:
