PORTS = as8051 asz80
SUBDIRS = $(PORTS) asxxsrc linksrc
BINDIR = bin
BINS = $(PORTS:%=$(BINDIR)/%) $(BINDIR)/aslink

all: subdirs bins

clean:
	for i in $(SUBDIRS); do make -C $$i clean; done

subdirs:
	for i in $(SUBDIRS); do make -C $$i; done

bins: bin-dir $(BINS)
	for i in $(PORTS); do \
	$(CC) -o $(BINDIR)/$$i lib/asxxxx.a lib/$$i.a; \
	done

$(BINDIR)/aslink: lib/aslink.a
	$(CC) -o $(BINDIR)/aslink lib/aslink.a

bin-dir:
	mkdir -p $(BINDIR)
