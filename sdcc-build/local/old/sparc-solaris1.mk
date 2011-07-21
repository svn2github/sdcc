# Sparc Solaris
# Dual processor
MAKEJOBFLAGS = -j 2
TARGETOS = sparc-sun-solaris
HOSTOS = sparc-sun-solaris

# the deafult GNU strip at /usr/local/bin has problems...
TARGETSTRIP=/usr/ccs/bin/strip
