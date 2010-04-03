# NetBSD on sparc64
# Dual procressor
MAKEJOBFLAGS = -j 2
TARGETOS = sparc64-unknown-netbsd
HOSTOS = sparc64-unknown-netbsd

# readline library at /usr/pkg/lib
TARGETLDFLAGS = "-L/usr/pkg/lib"

