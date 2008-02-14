# PPC G4 on MacOS X 10.5
# i386/ppc universal binaries
TARGETOS = ppc-apple-macosx
HOSTOS = ppc-apple-macosx

# proper naming of packages containing universal binaries
TARGET_PLATFORM = universal-apple-macosx

# an old readline version is installed on the machine,
# so I had to install new one (readline-5.2) to $(HOME)/local-$(HOSTNAME)
TARGETLDFLAGS = "-Wl,-syslibroot,/Developer/SDKs/MacOSX10.5.sdk -arch i386 -arch ppc -L$(HOME)/local-$(HOSTNAME)/lib"
TARGETCXXFLAGS = "-O2 -isysroot /Developer/SDKs/MacOSX10.5.sdk -arch i386 -arch ppc -I$(HOME)/local-$(HOSTNAME)/include"
TARGETCFLAGS = "-O2 -isysroot /Developer/SDKs/MacOSX10.5.sdk -arch i386 -arch ppc -I$(HOME)/local-$(HOSTNAME)/include"
