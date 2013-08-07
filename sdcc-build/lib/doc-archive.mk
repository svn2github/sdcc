# Prevent multiple inclusion
ifneq ($(DOCARCHIVEMKINCLUDE), 1)
DOCARCHIVEMKINCLUDE = 1

_DOC_ARCHIVE_BUILDROOT = $(HOME)

_DOC_ARCHIVE_SDCC_DIR = $(SRCDIR)/sdcc
_DOC_ARCHIVE_SRC_DIR = $(_DOC_ARCHIVE_SDCC_DIR)/doc
_DOC_ARCHIVE_ORIG_DIR = $(ORIGDIR)/sdcc
_DOC_ARCHIVE_BUILDDIR = $(TOPDIR)/build/$(TARGETOS)/docs
_DOC_ARCHIVE_SUPPORT_DIR = $(TOPDIR)/support

_DOC_ARCHIVE_DIR = $(HTDOCSDIR)/doc
_DOC_ARCHIVE_TARBALL_DIR = $(HTDOCSDIR)/$(TARBALLBASE)/docs

_DOC_ARCHIVE_MANUAL = sdccman

_DOC_ARCHIVE_SOURCES = $(addsuffix .lyx,$(_DOC_ARCHIVE_MANUAL))

_DOC_ARCHIVE_TXT = $(_DOC_ARCHIVE_SOURCES:.lyx=.txt)
_DOC_ARCHIVE_PDF = $(_DOC_ARCHIVE_SOURCES:.lyx=.pdf)
_DOC_ARCHIVE_TEX = $(_DOC_ARCHIVE_SOURCES:.lyx=.tex)
_DOC_ARCHIVE_HTML = $(_DOC_ARCHIVE_SOURCES:.lyx=.html)

.PHONY: build-doc-archive doc-archive-configure doc-archive-make doc-archive-copy doc-archive-build-archives

build-doc-archive: fetch-orig-trees doc-archive-configure doc-archive-make doc-archive-build-archives doc-archive-copy

doc-archive-configure:
	mkdir -p $(_DOC_ARCHIVE_SDCC_DIR)
	cd $(_DOC_ARCHIVE_SDCC_DIR); $(ORIGDIR)/sdcc/configure --enable-doc

doc-archive-make $(addprefix $(_DOC_ARCHIVE_SRC_DIR)/,*.txt *.html *.pdf):
	make -C $(_DOC_ARCHIVE_SDCC_DIR)/doc

doc-archive-copy:
#	# Create dirs for the HTML-doc
#	mkdir -p $(addprefix $(_DOC_ARCHIVE_DIR)/, $(_DOC_ARCHIVE_HTML))
#	# Copy everything except the HTML files (png, css)
#	-test -d $(_DOC_ARCHIVE_HTML) && cd $(_DOC_ARCHIVE_SRC_DIR) && \
#	  for dir in $(_DOC_ARCHIVE_HTML); do \
#	    find $$dir -maxdepth 1 -type f ! -name "*.html" -exec cp {} $(_DOC_ARCHIVE_DIR)/$$dir \; ; \
#	  done
#	# Mangle HTML files
#	-test -d $(_DOC_ARCHIVE_HTML) && cd $(_DOC_ARCHIVE_SRC_DIR) && \
#	  for i in sdccman.html/*.html; do \
#	    $(_DOC_ARCHIVE_SUPPORT_DIR)/sdcc_theme.pl -s "SDCC Manual" $$i > $(_DOC_ARCHIVE_DIR)/$$i; \
#	  done;
#	# PHP process .html files
#	-test -d $(_DOC_ARCHIVE_HTML) && \
#	  for i in $(addprefix $(_DOC_ARCHIVE_DIR)/, $(_DOC_ARCHIVE_HTML)); do \
#	    echo "AddType application/x-httpd-php .html" > $$i/.htaccess; \
#	  done
	# Create doc dir
	mkdir -p $(_DOC_ARCHIVE_DIR)
	# Copy *.pdf
	-test -f $(addprefix $(_DOC_ARCHIVE_SRC_DIR)/,$(_DOC_ARCHIVE_PDF)) && \
	  cp $(addprefix $(_DOC_ARCHIVE_SRC_DIR)/,$(_DOC_ARCHIVE_PDF)) $(_DOC_ARCHIVE_DIR)

doc-archive-build-archives: $(addprefix $(_DOC_ARCHIVE_SRC_DIR)/,*.txt *.html *.pdf)
	mkdir -p $(_DOC_ARCHIVE_TARBALL_DIR)
	rm -rf $(_DOC_ARCHIVE_BUILDDIR)
	mkdir -p $(_DOC_ARCHIVE_BUILDDIR)/doc/ucsim
	mkdir -p $(_DOC_ARCHIVE_BUILDDIR)/doc/sdas
	# copy to build directory
	cd $(_DOC_ARCHIVE_SRC_DIR); \
	ls *.txt > /dev/null 2>&1 && cp -rpf *.txt $(_DOC_ARCHIVE_BUILDDIR)/doc; \
	ls *.html > /dev/null 2>&1 && cp -rpf *.html $(_DOC_ARCHIVE_BUILDDIR)/doc; \
	ls *.pdf > /dev/null 2>&1 && cp -rpf *.pdf $(_DOC_ARCHIVE_BUILDDIR)/doc
	cd $(_DOC_ARCHIVE_ORIG_DIR); \
	cp -rpf sdas/doc/* $(_DOC_ARCHIVE_BUILDDIR)/doc/sdas/; \
	cp -pf doc/*.txt doc/*.html $(_DOC_ARCHIVE_BUILDDIR)/doc; \
	cp -pf ChangeLog $(_DOC_ARCHIVE_BUILDDIR)/doc/ChangeLog.txt
	cd $(_DOC_ARCHIVE_ORIG_DIR)/sim/ucsim/doc; cp -rpf *.html *.jpg *.gif *.fig $(_DOC_ARCHIVE_BUILDDIR)/doc/ucsim/
	# Create knownbugs.html
	read _VER < $(ORIGDIR)/sdcc/.version; perl $(ORIGDIR)/sdcc/support/scripts/gen_known_bugs.pl $$_VER > $(_DOC_ARCHIVE_BUILDDIR)/doc/knownbugs.html
	# create tar.gz doc package
	cd $(_DOC_ARCHIVE_BUILDDIR); tar -cjf $(_DOC_ARCHIVE_TARBALL_DIR)/sdcc-doc-$(SNAPSHOTID).tar.bz2 doc
	# create zip doc package
	find $(_DOC_ARCHIVE_BUILDDIR) -type f \( -name '*.txt' -o -name '*.html' -name 'ChangeLog' \) -exec $(UNIX2DOS) {} \;
	cd $(_DOC_ARCHIVE_BUILDDIR); zip -9r $(_DOC_ARCHIVE_TARBALL_DIR)/sdcc-doc-$(SNAPSHOTID).zip doc

endif
