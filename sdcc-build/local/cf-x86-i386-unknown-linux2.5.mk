# Generate 32 bit i386 Linux executables on
# AMD Sempron with Fedora Core release 6

# Spawn 2 make proceses
MAKEJOBFLAGS = -j 2

TARGETOS = i386-unknown-linux2.5
HOSTOS = amd64-unknown-linux2.5

TARGETCC  = "gcc -march=i386 -m32"
TARGETCXX = "g++ -march=i386 -m32"
