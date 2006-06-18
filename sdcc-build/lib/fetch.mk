# Makefile that can fetch a copy of the source trees
_FETCH_EXT = $(BUILDDATE)-fetched
_FETCH_ORIGSRCTREES = $(SRCTREES:%=$(STAMPDIR)/%.$(_FETCH_EXT))

# Default rule for fetching a tree from svn
$(STAMPDIR)/%.$(_FETCH_EXT):
	ssh $(SVNSERVER) ' \
	mkdir -p $(STAMPDIR); \
	mkdir -p $(ORIGDIR); \
	rm -f $(STAMPDIR)/sdcc.*-fetched; \
	rm -rf $(ORIGDIR)/sdcc; \
	cd $(ORIGDIR); \
	if [ "$(ISRELEASE)" == "true" ]; \
	then \
	  svn $(SVNFLAGS) export https://svn.sourceforge.net/svnroot/sdcc/tags/$(SVNTAG)/$(shell basename $@ .$(_FETCH_EXT)) $(shell basename $@ .$(_FETCH_EXT))
; \
	else \
	  svn $(SVNFLAGS) export https://svn.sourceforge.net/svnroot/sdcc/trunk/$(shell basename $@ .$(_FETCH_EXT)) $(shell basename $@ .$(_FETCH_EXT))'

fetch-orig-trees: $(_FETCH_ORIGSRCTREES)
