include ../packages.mk

GMP_VERSION = 5.0.4
MPFR_VERSION = 3.1.0
MPC_VERSION = 0.9

GMP_DIR = gmp-$(GMP_VERSION)
MPFR_DIR = mpfr-$(MPFR_VERSION)
MPC_DIR = mpc-$(MPC_VERSION)

ifeq ($(OS),SunOS)
  CFGENV=CFLAGS='-xO3 -m32' ABI=32
endif

.PHONY: all
all: gmp-install.tag gmp-clean mpfr-install.tag mpfr-clean mpc-install.tag mpc-clean

.PHONY: clean
clean: gmp-clean mpfr-clean mpc-clean
	rm -rf download/* *.tag


download/gmp-$(GMP_VERSION).tar.bz2:
	wget -P download ftp://ftp.gnu.org/gnu/gmp/gmp-$(GMP_VERSION).tar.bz2

gmp-unpack.tag: download/gmp-$(GMP_VERSION).tar.bz2
	tar xjf download/gmp-$(GMP_VERSION).tar.bz2
	touch $@

gmp-configure.tag: gmp-unpack.tag
	cd $(GMP_DIR) && \
	./configure --prefix=$(LOCAL_DIR) $(CFGENV)
	touch $@

gmp-make.tag: gmp-configure.tag
	make -C $(GMP_DIR)
	touch $@

gmp-install.tag: gmp-make.tag
	make -C $(GMP_DIR) install
	touch $@


download/mpfr-$(MPFR_VERSION).tar.bz2:
	wget -P download http://www.mpfr.org/mpfr-current/mpfr-$(MPFR_VERSION).tar.bz2

mpfr-unpack.tag: download/mpfr-$(MPFR_VERSION).tar.bz2
	tar xjf download/mpfr-$(MPFR_VERSION).tar.bz2
	touch $@

mpfr-configure.tag: mpfr-unpack.tag
	cd $(MPFR_DIR) && \
	./configure --prefix=$(LOCAL_DIR) --with-gmp=$(LOCAL_DIR) $(CFGENV)
	touch $@

mpfr-make.tag: mpfr-configure.tag
	make -C $(MPFR_DIR)
	touch $@

mpfr-install.tag: mpfr-make.tag
	make -C $(MPFR_DIR) install
	touch $@


download/mpc-$(MPC_VERSION).tar.gz:
	wget -P download http://www.multiprecision.org/mpc/download/mpc-$(MPC_VERSION).tar.gz

mpc-unpack.tag: download/mpc-$(MPC_VERSION).tar.gz
	tar xzf download/mpc-$(MPC_VERSION).tar.gz
	touch $@

mpc-configure.tag: mpc-unpack.tag
	cd $(MPC_DIR) && \
	./configure --prefix=$(LOCAL_DIR) --with-gmp=$(LOCAL_DIR) --with-mpfr=$(LOCAL_DIR) $(CFGENV)
	touch $@

mpc-make.tag: mpc-configure.tag
	make -C $(MPC_DIR)
	touch $@

mpc-install.tag: mpc-make.tag
	make -C $(MPC_DIR) install
	touch $@


.PHONY: gmp-clean
gmp-clean:
	rm -rf $(GMP_DIR) gmp-*.tag

.PHONY: mpfr-clean
mpfr-clean:
	rm -rf $(MPFR_DIR) mpfr-*.tag

.PHONY: mpc-clean
mpc-clean:
	rm -rf $(MPC_DIR) mpc-*.tag
