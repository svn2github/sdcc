# Sparc Solaris
# Dual processor
MAKEJOBFLAGS = -j 2
TARGETOS = sparc-sun-solaris2.9
HOSTOS = sparc-sun-solaris2.9
# the deafult GNU strip at /usr/local/bin has problems...
TARGETSTRIP=/usr/ccs/bin/strip
