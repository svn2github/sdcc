# List of all source trees that need to be fetched either locally or from cvs
SRCTREES += 
# Target to build for.  Currently unused.
TARGET = i386-unknown-linux2.2
# Compiler to build with
TARGETCC = gcc

TOPDIR = /home/michaelh/projects/sdcc-build
# Directory that all of the soure trees get copied into
SRCDIR = src
ORIGDIR = orig
BUILDDIR = $(TOPDIR)/build/$(TARGET)
BINDIR= $(BUILDDIR)/bin

CVSFLAGS += -z5
STAMPDIR = stamps
RSYNCFLAGS = -C -r

$(STAMPDIR):
	mkdir -p $(STAMPDIR)
