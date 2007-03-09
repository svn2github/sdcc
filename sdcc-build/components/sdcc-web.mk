# Prevent multiple inclusion
ifneq ($(SDCCWEBMKINCLUDE), 1)
SDCCWEBMKINCLUDE = 1

# Add sdcc-web to the list of source trees that need to be fetched
SRCTREES += sdcc-web

_SDCC_WEB_ORIG_DIR = $(ORIGDIR)/sdcc-web

.PHONY: sdcc-web-copy

build-sdcc-web: fetch-orig-trees sdcc-web-copy

sdcc-web-copy:
	# Create dirs for the WEB
	mkdir -p $(HTDOCSDIR)
	# Copy everything
	cp -r $(_SDCC_WEB_ORIG_DIR)/* $(HTDOCSDIR)

endif
