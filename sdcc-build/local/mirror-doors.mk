# PPC G4 on MacOS X 10.4
TARGETOS = ppc-apple-macosx
HOSTOS = ppc-apple-macosx

# Build universal binaries
# an old readline version is installed on the machine,
# so I had to install new one (readline-5.2) to $(HOME)/local-$(HOSTNAME)
TARGETLDFLAGS = "-isysroot /Developer/SDKs/MacOSX10.4u.sdk -arch i386 -arch ppc -L$(HOME)/local-$(HOSTNAME)/lib"
TARGETCXXFLAGS = "-isysroot /Developer/SDKs/MacOSX10.4u.sdk -arch i386 -I$(HOME)/local-$(HOSTNAME)/include"
TARGETCFLAGS = "-isysroot /Developer/SDKs/MacOSX10.4u.sdk -arch i386 -I$(HOME)/local-$(HOSTNAME)/include"
