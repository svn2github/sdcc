# i386 on MacOS X 10.4 using Xcode 2.5
# i386/ppc universal binaries
# NOTE: Binaries generated with Xcode 3.0 seems not to be backward compatible with Mac OS X 10.4 and older

TARGETOS = i386-apple-darwin
HOSTOS = i386-apple-darwin

# proper naming of packages containing universal binaries
TARGET_PLATFORM = i386_universal-apple-macosx

TARGETCC = "/Developer/usr/bin/gcc"
TARGETCXX = "/Developer/usr/bin/g++"

SDCCCONFIGUREFLAGS = --disable-dependency-tracking

# local includes and libraries
# An old readline version is installed on the machine,
# so I had to install new one (readline-5.2) to $(HOME)/local-$(HOSTNAME)
TARGETLDFLAGS = "-Wl,-syslibroot,/Developer/SDKs/MacOSX10.4u.sdk -arch i386 -arch ppc -L$(HOME)/local-$(HOSTNAME)/lib"
TARGETCXXFLAGS = "-O2 -isysroot /Developer/SDKs/MacOSX10.4u.sdk -arch i386 -arch ppc -I$(HOME)/local-$(HOSTNAME)/include"
TARGETCFLAGS = "-O2 -isysroot /Developer/SDKs/MacOSX10.4u.sdk -arch i386 -arch ppc -I$(HOME)/local-$(HOSTNAME)/include"
TARGETCPPFLAGS = "-I$(HOME)/local-$(HOSTNAME)/include"
