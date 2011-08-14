# Generate native 64 bit amd64 Linux executables on
# AMD Sempron with Fedora Core release 6

# Spawn 2 make proceses
MAKEJOBFLAGS = -j 2

TARGETOS = amd64-unknown-linux2.5
HOSTOS = amd64-unknown-linux2.5

# local includes and libraries
TARGETCXXFLAGS = "-O2 -I$(HOME)/local-$(HOSTNAME)/include"
TARGETCFLAGS = "-O2 -I$(HOME)/local-$(HOSTNAME)/include"
TARGETLDFLAGS = "-L$(HOME)/local-$(HOSTNAME)/lib"

# cross-tools are installed
####OTHERTARGETS = i586-mingw32msvc i386-unknown-linux2.5
OTHERTARGETS = i586-mingw32msvc

# for backward compatibility
# FC6 uses --hash-style=gnu by default
TARGETLDFLAGS = -Wl,--hash-style=both
