# PPC G4 on MacOS X 10.4
TARGETOS = ppc-apple-macosx
HOSTOS = ppc-apple-macosx

# an old version is installed on the machine,
# so I had to install new one (version 5.2) to $(HOME)/local-$(HOSTNAME)
TARGETLDFLAGS = "-L$(HOME)/local-$(HOSTNAME)/lib"
TARGETCXXFLAGS = "-I$(HOME)/local-$(HOSTNAME)/include"
TARGETCFLAGS = "-I$(HOME)/local-$(HOSTNAME)/include"
