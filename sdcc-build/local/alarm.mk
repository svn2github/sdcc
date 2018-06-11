# Generate AARCH64 Linux executables on
# ArchLinux on Raspberry Pi 3
# https://archlinuxarm.org/

# Spawn 1 make process:
# spawning more than 1 processes leads to system freeze
MAKEJOBFLAGS = -j 1

HOSTOS = aarch64-unknown-linux-gnu
TARGETOS = aarch64-unknown-linux-gnu

# local includes and libraries
TARGETCXXFLAGS = "-O2 -I$(HOME)/local-$(HOSTNAME)/include"
TARGETCFLAGS = "-O2 -I$(HOME)/local-$(HOSTNAME)/include"
TARGETCPPFLAGS = "-I$(HOME)/local-$(HOSTNAME)/include"
TARGETLDFLAGS = "-L$(HOME)/local-$(HOSTNAME)/lib"
