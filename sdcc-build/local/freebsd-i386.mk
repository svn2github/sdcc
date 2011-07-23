# FreeBSD on i386
# Dual processor

# Spawn 2 make proceses
MAKEJOBFLAGS = -j 2

TARGETOS = i386-unknown-freebsd
HOSTOS = i386-unknown-freebsd

# local includes and libraries
TARGETCXXFLAGS = "-O2 -I$(HOME)/local-$(HOSTNAME)/include"
TARGETCFLAGS = "-O2 -I$(HOME)/local-$(HOSTNAME)/include"
TARGETLDFLAGS = "-L$(HOME)/local-$(HOSTNAME)/lib"
