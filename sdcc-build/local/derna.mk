# Generate 32 bit i386 Linux executables on
# Debian on i686

# Spawn 2 make proceses
MAKEJOBFLAGS = -j 2

HOSTOS = i386-unknown-linux2.5
TARGETOS = i386-unknown-linux2.5

# local includes and libraries
TARGETCXXFLAGS = "-O2 -I$(HOME)/local-$(HOSTNAME)/include"
TARGETCFLAGS = "-O2 -I$(HOME)/local-$(HOSTNAME)/include"
TARGETCPPFLAGS = "-I$(HOME)/local-$(HOSTNAME)/include"
TARGETLDFLAGS = "-L$(HOME)/local-$(HOSTNAME)/lib32"

# cross-tools are installed
OTHERTARGETS = i586-mingw32msvc

# for backward compatibility
# FC6 uses --hash-style=gnu by default
TARGETLDFLAGS += -Wl,--hash-style=both
