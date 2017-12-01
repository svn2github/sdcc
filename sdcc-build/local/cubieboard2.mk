# Generate ARMv7 armhf Linux executables on
# Archlinux on Cubieboard 2

# Spawn 1 make process:
# spawning 2 processes leads to a compilation error
MAKEJOBFLAGS = -j 1

HOSTOS = armv7l-unknown-linux-gnueabihf
TARGETOS = armv7l-unknown-linux-gnueabihf
 
# disable pic14 and pic16 due to broken gputils on archlinux/armv7l
SDCCCONFIGUREFLAGS = "--disable-pic14-port --disable-pic16-port"

# local includes and libraries
TARGETCXXFLAGS = "-O2 -I$(HOME)/local-$(HOSTNAME)/include"
TARGETCFLAGS = "-O2 -I$(HOME)/local-$(HOSTNAME)/include"
TARGETCPPFLAGS = "-I$(HOME)/local-$(HOSTNAME)/include"
TARGETLDFLAGS = "-L$(HOME)/local-$(HOSTNAME)/lib"
