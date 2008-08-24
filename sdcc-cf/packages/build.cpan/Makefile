include ../packages.mk

VERSION=$(shell expr download/HTML-Tree-*.tar.gz : 'download/HTML-Tree-\(.*\).tar.gz')

HTML_TREE_DIR=HTML-Tree-$(VERSION)

.PHONY: all
all: HTML-Tree-install.tag clean

HTML-Tree-download.tag:
	wget -P download http://search.cpan.org/CPAN/authors/id/P/PE/PETEK/HTML-Tree-3.23.tar.gz
	touch $@

HTML-Tree-unpack.tag: HTML-Tree-download.tag
	tar xzvf download/$(HTML_TREE_DIR).tar.gz
	touch $@

HTML-Tree-configure.tag: HTML-Tree-unpack.tag
	cd $(HTML_TREE_DIR) && \
	perl Makefile.PL PREFIX=$(LOCAL_DIR)
	touch $@

HTML-Tree-make.tag: HTML-Tree-configure.tag
	$(MAKE) -C $(HTML_TREE_DIR)
	touch $@

HTML-Tree-install.tag: HTML-Tree-make.tag
	$(MAKE) -C $(HTML_TREE_DIR) install
	touch $@

clean:
	rm -rf $(HTML_TREE_DIR) *.tag
	@echo '***************************************************************'
	@echo "Add the following line to ~/.bash_profile:"
	@echo "    export PERL5LIB=~/local-$(HOSTNAME)/lib/perl5/site_perl/"$$(perl -e "print(substr($$^V, 1))")
	@echo '***************************************************************'
