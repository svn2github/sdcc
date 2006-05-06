_PROJECT_DIR = /home/groups/s/sd/sdcc
_PROJECT_DOC_DIR = $(_PROJECT_DIR)/htdocs/doc
_PROJECT_SNAPDOC_DIR = $(_PROJECT_DIR)/htdocs/snapshots/docs

_DOC_ARCHIVE_BUILDDATE = $(shell date +%Y%m%d)

_DOC_ARCHIVE_BUILDROOT = $(HOME)

_DOC_ARCHIVE_SDCC_DIR = $(SRCDIR)/sdcc
_DOC_ARCHIVE_DOC_DIR = $(_DOC_ARCHIVE_SDCC_DIR)/doc
_DOC_ARCHIVE_TMP_DIR = $(TOPDIR)/tmp
_DOC_ARCHIVE_SUPPORT_DIR = $(TOPDIR)/support

_DOC_ARCHIVE_MANUAL = sdccman
_DOC_ARCHIVE_TSS = test_suite_spec
_DOC_ARCHIVE_CDB = cdbfileformat

_DOC_ARCHIVE_SOURCES = $(addsuffix .lyx,$(_DOC_ARCHIVE_MANUAL) $(_DOC_ARCHIVE_TSS) $(_DOC_ARCHIVE_CDB))

_DOC_ARCHIVE_TXT = $(_DOC_ARCHIVE_SOURCES:.lyx=.txt)
_DOC_ARCHIVE_PDF = $(_DOC_ARCHIVE_SOURCES:.lyx=.pdf)
_DOC_ARCHIVE_TEX = $(_DOC_ARCHIVE_SOURCES:.lyx=.tex)
_DOC_ARCHIVE_HTML = $(_DOC_ARCHIVE_SOURCES:.lyx=.html)

_DOC_ARCHIVE_HTML_DIRS = $(addprefix $(_DOC_ARCHIVE_DOC_DIR)/,$(_DOC_ARCHIVE_HTML))
_DOC_ARCHIVE_TMP_HTML_DIRS = $(addprefix $(_DOC_ARCHIVE_TMP_DIR)/,$(_DOC_ARCHIVE_HTML))

_DOC_ARCHIVE_ARCHIVES = sdcc-doc-$(BUILDDATE).tar.gz sdcc-doc-$(BUILDDATE).zip

build-doc-archive: doc-archive-build-archives doc-archive-copy doc-archive-copy-archives

doc-archive-copy: doc-archive-copy-txt doc-archive-copy-pdf doc-archive-copy-tex doc-archive-copy-html

doc-archive-copy-txt:
	rsync -v -e ssh $(addprefix $(_DOC_ARCHIVE_DOC_DIR)/,$(_DOC_ARCHIVE_TXT)) shell1.sourceforge.net:$(_PROJECT_DOC_DIR)

doc-archive-copy-pdf:
	rsync -v -e ssh $(addprefix $(_DOC_ARCHIVE_DOC_DIR)/,$(_DOC_ARCHIVE_PDF)) shell1.sourceforge.net:$(_PROJECT_DOC_DIR)

doc-archive-copy-tex:
	rsync -v -e ssh $(addprefix $(_DOC_ARCHIVE_DOC_DIR)/,$(_DOC_ARCHIVE_TEX)) shell1.sourceforge.net:$(_PROJECT_DOC_DIR)

doc-archive-copy-html:
	# Create dirs for the HTML-doc
	mkdir -p $(_DOC_ARCHIVE_TMP_HTML_DIRS)
	# Copy everything except the HTML files (png, css)
	cd $(_DOC_ARCHIVE_DOC_DIR); \
	for dir in $(_DOC_ARCHIVE_HTML); do \
	  find $$dir -maxdepth 1 -type f ! -name "*.html" -exec cp {} $(_DOC_ARCHIVE_TMP_DIR)/$$dir \; ; \
        done
	# Mangle HTML files
	cd $(_DOC_ARCHIVE_DOC_DIR); SDCC_SECTION="SDCC Manual"    ; for i in sdccman.html/*.html        ; do $(_DOC_ARCHIVE_SUPPORT_DIR)/sdcc_theme.pl -f $(_DOC_ARCHIVE_SUPPORT_DIR)/sdcc_theme_navbar.html $$i > $(_DOC_ARCHIVE_TMP_DIR)/$$i; done
	cd $(_DOC_ARCHIVE_DOC_DIR); SDCC_SECTION="SDCC Test Suite"; for i in test_suite_spec.html/*.html; do $(_DOC_ARCHIVE_SUPPORT_DIR)/sdcc_theme.pl -f $(_DOC_ARCHIVE_SUPPORT_DIR)/sdcc_theme_navbar.html $$i > $(_DOC_ARCHIVE_TMP_DIR)/$$i; done
	cd $(_DOC_ARCHIVE_DOC_DIR); SDCC_SECTION="SDCC CDB Format"; for i in cdbfileformat.html/*.html  ; do $(_DOC_ARCHIVE_SUPPORT_DIR)/sdcc_theme.pl -f $(_DOC_ARCHIVE_SUPPORT_DIR)/sdcc_theme_navbar.html $$i > $(_DOC_ARCHIVE_TMP_DIR)/$$i; done
	cd $(_DOC_ARCHIVE_TMP_DIR); rsync -vrC --delete -e ssh $(_DOC_ARCHIVE_HTML) shell1.sourceforge.net:$(_PROJECT_DOC_DIR)

doc-archive-build-archives: $(addprefix $(_DOC_ARCHIVE_DOC_DIR)/,*.txt *.html *.pdf z80/* avr/*) \
		     $(addprefix $(_DOC_ARCHIVE_SDCC_DIR)/,as/* \
		     sim/ucsim/doc/*.html sim/ucsim/doc/*.jpg sim/ucsim/doc/*.gif sim/ucsim/doc/*.fig)
	rm -rf $(_DOC_ARCHIVE_TMP_DIR)
	mkdir -p $(_DOC_ARCHIVE_TMP_DIR)/doc/ucsim
	cd $(_DOC_ARCHIVE_DOC_DIR); cp -rpf *.txt *.html *.pdf z80/ avr/ $(_DOC_ARCHIVE_TMP_DIR)/doc
	cd $(_DOC_ARCHIVE_SDCC_DIR); cp -rpf as/doc/ $(_DOC_ARCHIVE_TMP_DIR)/doc/as/
	cd $(_DOC_ARCHIVE_SDCC_DIR)/sim/ucsim/doc; cp -rpf *.html *.jpg *.gif *.fig $(_DOC_ARCHIVE_TMP_DIR)/doc/ucsim/
	cd $(_DOC_ARCHIVE_TMP_DIR); tar -czf sdcc-doc-$(_DOC_ARCHIVE_BUILDDATE).tar.gz doc
	find $(_DOC_ARCHIVE_TMP_DIR) -name "*.txt" -exec unix2dos {} \;
	cd $(_DOC_ARCHIVE_TMP_DIR); zip -9r sdcc-doc-$(_DOC_ARCHIVE_BUILDDATE).zip doc

doc-archive-copy-archives:
	rsync -v -e ssh --size-only $(addprefix $(_DOC_ARCHIVE_TMP_DIR)/,$(_DOC_ARCHIVE_ARCHIVES)) shell1.sourceforge.net:$(_PROJECT_SNAPDOC_DIR)
