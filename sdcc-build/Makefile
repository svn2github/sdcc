# Top level Makefile for sdcc-build.
# See README, and try 'make help'

all: build

include lib/variables.mk
include lib/version.mk
include lib/local.mk
include lib/cross.mk
include lib/ports.mk

include components/sdcc.mk
include components/sdcc-extra.mk
include components/sdcc-web.mk

include lib/bugs.mk
include lib/fetch.mk
include lib/send-mail.mk
include lib/upload.mk
include lib/clean.mk
include lib/install.mk
include lib/help.mk
include lib/release.mk
include lib/bootstrap.mk
include lib/src-archive.mk
include lib/doc-archive.mk

build: dirs fetch-orig-trees sdcc sdcc-install-clean sdcc-install

test-integrity:
	@echo Target: $(TARGETOS)

fail:
	false
