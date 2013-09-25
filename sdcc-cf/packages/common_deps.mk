.PHONY: all do-all unpack-downloaded-package uninstall clean
do-all: $(PACKAGE)-install.tag clean

unpack-downloaded-package: download/$(PACKAGE_FILE)
	$(call AR_FUNC,$<) -dc $< | tar xvf -

uninstall: $(PACKAGE)-make.tag
	$(MAKE) -C $(PACKAGE_DIR) uninstall
	$(MAKE) clean

clean:
	rm -rf $(PACKAGE_DIR) *.tag
