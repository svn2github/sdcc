# FreeBSD on i386
# Dual processor

# Spawn 2 make proceses
## disabled 2012-01-16 by borutr since src/z80/ralloc2.cc compilation
## mysteriously fails if enabled
##MAKEJOBFLAGS = -j 2

TARGETOS = i386-unknown-freebsd
HOSTOS = i386-unknown-freebsd

# local includes and libraries
TARGETCXXFLAGS = "-O2 -I$(HOME)/local-$(HOSTNAME)/include"
TARGETCFLAGS = "-O2 -I$(HOME)/local-$(HOSTNAME)/include"
TARGETCPPFLAGS = "-I$(HOME)/local-$(HOSTNAME)/include"
TARGETLDFLAGS = "-L$(HOME)/local-$(HOSTNAME)/lib"
