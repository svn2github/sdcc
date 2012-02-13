# PPC G4 on MacOS X 10.5 using Xcode 2.5
# i386/ppc universal binaries
# NOTE: Binaries generated with Xcode 3.0 seems not to be backward compatible with Mac OS X 10.4 and older

TARGETOS = ppc-apple-macosx
HOSTOS = ppc-apple-macosx

# proper naming of packages containing universal binaries
TARGET_PLATFORM = universal-apple-macosx

TARGETCC = "/Xcode2.5/usr/bin/gcc"
TARGETCXX = "/Xcode2.5/usr/bin/g++"

SDCCCONFIGUREFLAGS = --disable-dependency-tracking

# local includes and libraries
# An old readline version is installed on the machine,
# so I had to install new one (readline-5.2) to $(HOME)/local-$(HOSTNAME)
TARGETLDFLAGS = "-Wl,-syslibroot,/Xcode2.5/SDKs/MacOSX10.4u.sdk -arch i386 -arch ppc -L$(HOME)/local-$(HOSTNAME)/lib"
TARGETCXXFLAGS = "-O2 -isysroot /Xcode2.5/SDKs/MacOSX10.4u.sdk -arch i386 -arch ppc -I$(HOME)/local-$(HOSTNAME)/include"
TARGETCFLAGS = "-O2 -isysroot /Xcode2.5/SDKs/MacOSX10.4u.sdk -arch i386 -arch ppc -I$(HOME)/local-$(HOSTNAME)/include"
TARGETCPPFLAGS = "-I$(HOME)/local-$(HOSTNAME)/include"
