# NetBSD on i386
# Dual procressor
MAKEJOBFLAGS = -j 2
TARGETOS = i386-unknown-netbsd
HOSTOS = i386-unknown-netbsd

# readline library at /usr/pkg/lib 
TARGETLDFLAGS = "-L/usr/pkg/lib"
