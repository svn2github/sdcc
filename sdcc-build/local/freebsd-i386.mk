# FreeBSD on i386
# Dual processor
MAKEJOBFLAGS = -j 2
TARGETOS = i386-unknown-freebsd
HOSTOS = i386-unknown-freebsd

TARGETCXXFLAGS = "-O2 -I$(HOME)/local-$(HOSTNAME)/include"
