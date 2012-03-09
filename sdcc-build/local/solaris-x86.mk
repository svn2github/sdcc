# Solaris on i386
# Dual processor
#MAKEJOBFLAGS = -j 2
TARGETOS = i386-sun-solaris
HOSTOS = i386-sun-solaris

# local includes and libraries
TARGETCXXFLAGS = "-O2 -I$(HOME)/local-$(HOSTNAME)/include"
TARGETCFLAGS = "-O2 -I$(HOME)/local-$(HOSTNAME)/include"
TARGETCPPFLAGS = "-I$(HOME)/local-$(HOSTNAME)/include"
TARGETLDFLAGS = "-L$(HOME)/local-$(HOSTNAME)/lib"
