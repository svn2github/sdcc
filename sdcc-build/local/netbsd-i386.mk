# NetBSD on i386
# Dual procressor
MAKEJOBFLAGS = -j 2
TARGETOS = i386-unknown-netbsd
HOSTOS = i386-unknown-netbsd

# local includes and libraries
TARGETCXXFLAGS = "-O2 -I$(HOME)/local-$(HOSTNAME)/include"
TARGETCFLAGS = "-O2 -I$(HOME)/local-$(HOSTNAME)/include"
# readline library at /usr/pkg/lib 
TARGETLDFLAGS = "-L$(HOME)/local-$(HOSTNAME)/lib -L/usr/pkg/lib"
