# NetBSD on sparc64
# Dual procressor
MAKEJOBFLAGS = -j 2
TARGETOS = sparc64-unknown-netbsd
HOSTOS = sparc64-unknown-netbsd

# local includes and libraries
# readline at /usr/pkg
TARGETCXXFLAGS = "-O2 -I$(HOME)/local-$(HOSTNAME)/include -I/usr/pkg/include"
TARGETCFLAGS = "-O2 -I$(HOME)/local-$(HOSTNAME)/include -I/usr/pkg/include"
TARGETCPPFLAGS = "-I$(HOME)/local-$(HOSTNAME)/include -I/usr/pkg/include"
TARGETLDFLAGS = "-L$(HOME)/local-$(HOSTNAME)/lib -L/usr/pkg/lib"
