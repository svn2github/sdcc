# Generate ARMv6 armhf Linux executables on
# Debian (Raspbian) on Raspberry Pi

# Spawn 1 make process:
# spawning 2 processes leads to a compilation error
MAKEJOBFLAGS = -j 1

HOSTOS = armv6l-unknown-linux-gnueabihf
TARGETOS = armv6l-unknown-linux-gnueabihf

# local includes and libraries
TARGETCXXFLAGS = "-O2 -I$(HOME)/local-$(HOSTNAME)/include"
TARGETCFLAGS = "-O2 -I$(HOME)/local-$(HOSTNAME)/include"
TARGETCPPFLAGS = "-I$(HOME)/local-$(HOSTNAME)/include"
TARGETLDFLAGS = "-L$(HOME)/local-$(HOSTNAME)/lib"
