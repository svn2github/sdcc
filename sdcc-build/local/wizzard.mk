# Generate ARMv6 armhf Linux executables on
# Debian (Raspbian) on Raspberry Pi

# Spawn 2 make proceses
MAKEJOBFLAGS = -j 2

HOSTOS = armv6l-unknown-linux-gnueabihf
TARGETOS = armv6l-unknown-linux-gnueabihf

# local includes and libraries
TARGETCXXFLAGS = "-O2 -fsigned-char -I$(HOME)/local-$(HOSTNAME)/include"
TARGETCFLAGS = "-O2 -fsigned-char -I$(HOME)/local-$(HOSTNAME)/include"
TARGETCPPFLAGS = "-I$(HOME)/local-$(HOSTNAME)/include"
TARGETLDFLAGS = "-L$(HOME)/local-$(HOSTNAME)/lib"
