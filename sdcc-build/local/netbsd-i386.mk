# NetBSD on i386
# Dual procressor
## disabled 2012-03-17 by borutr since src/SDCCnaddr.cc compilation
## mysteriously fails if enabled
##MAKEJOBFLAGS = -j 2
TARGETOS = i386-unknown-netbsd
HOSTOS = i386-unknown-netbsd

# local includes and libraries
# readline at /usr/pkg
TARGETCXXFLAGS = "-O2 -I$(HOME)/local-$(HOSTNAME)/include -I/usr/pkg/include"
TARGETCFLAGS = "-O2 -I$(HOME)/local-$(HOSTNAME)/include -I/usr/pkg/include"
TARGETCPPFLAGS = "-I$(HOME)/local-$(HOSTNAME)/include -I/usr/pkg/include"
TARGETLDFLAGS = "-L$(HOME)/local-$(HOSTNAME)/lib -L/usr/pkg/lib"
