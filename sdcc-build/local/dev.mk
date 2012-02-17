# Solaris on sparc
# Dual processor
#MAKEJOBFLAGS = -j 2
TARGETOS = sparc-sun-solaris
HOSTOS = sparc-sun-solaris

# local includes and libraries
TARGETCXXFLAGS = "-O2 -I$(HOME)/local-$(HOSTNAME)/include"
TARGETCFLAGS = "-O2 -I$(HOME)/local-$(HOSTNAME)/include"
TARGETCPPFLAGS = "-I$(HOME)/local-$(HOSTNAME)/include"
TARGETLDFLAGS = "-L$(HOME)/local-$(HOSTNAME)/lib"
