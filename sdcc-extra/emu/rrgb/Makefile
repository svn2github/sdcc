# Makefile for rrgb
VER = 0.35

# this looks wrong, but *ops.c are actually #include'd by z80.c
OBJS=main.o z80.o parse_map.o debugger.o disgb.o csock.o
CC=gcc
OPTS = -DSEG -g
#CFLAGS=-O3 -fomit-frame-pointer -funroll-loops -Wall $(OPTS)
CFLAGS= $(OPTS) -Wall
ifeq ($(shell uname -s),SunOS)
LIBS = -lm -lsocket
else
LIBS = -lm
endif

all: rrgb

rrgb: $(OBJS)
	$(CC) $(OPTS) $(LIBS) -o rrgb $(OBJS)

clean:
	$(RM) *.o *~ rrgb

install:
	install --strip rrgb /usr/bin

src-dist: clean
	tar czf ../rrgb-$(VER).tar.gz *

# Dependencies

z80.o: z80.c z80.h z80ops.c cbops.c

main.o: z80.h disgb.h
