SRC =	z80.c z80optab.c z80_step.c \
	z80_op1.c z80_op2.c z80_op3.c z80_op4.c z80_op5.c z80_op6.c

OBJ = $(SRC:.c=.o)
LIB = libz80cpu.a

CFLAGS = -DZ80C=1 -DCLEAR_MEM=1 -DHIJACK_RST_08=1 -O2 -Wall
CC = gcc

# Defines:
# SPECT_MEM
# COMPARISON - something to do with the VM context run ontop of.
# Z80C - Unknown

all: $(LIB)

$(LIB): $(OBJ)
	ar r $(LIB) $(OBJ)
	ranlib $(LIB)

clean:
	rm -f *.o *~ *.a
