# PPC G4 on MacOS X 10.5 using Xcode 3.1.3
# i386/ppc universal binaries

TARGETOS = ppc-apple-macosx
HOSTOS = ppc-apple-macosx

# proper naming of packages containing universal binaries
TARGET_PLATFORM = universal-apple-macosx

TARGETCC = "/Developer/usr/bin/gcc"
TARGETCXX = "/Developer/usr/bin/g++"

SDCCCONFIGUREFLAGS = --disable-dependency-tracking

# local includes and libraries
# Using readline-6.2 installed to $(HOME)/local-$(HOSTNAME)
TARGETLDFLAGS = "-Wl,-syslibroot,/Developer/SDKs/MacOSX10.4u.sdk -arch i386 -arch ppc -L$(HOME)/local-$(HOSTNAME)/lib -mmacosx-version-min=10.4"
TARGETCXXFLAGS = "-O2 -isysroot /Developer/SDKs/MacOSX10.4u.sdk -arch i386 -arch ppc -I$(HOME)/local-$(HOSTNAME)/include -mmacosx-version-min=10.4"
TARGETCFLAGS = "-O2 -isysroot /Developer/SDKs/MacOSX10.4u.sdk -arch i386 -arch ppc -I$(HOME)/local-$(HOSTNAME)/include -mmacosx-version-min=10.4"
TARGETCPPFLAGS = "-I$(HOME)/local-$(HOSTNAME)/include"
