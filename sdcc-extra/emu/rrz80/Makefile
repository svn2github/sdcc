SRC = rrz80.c
OBJ = $(SRC:.c=.o)

BIN = rrz80

CC = gcc
CFLAGS = -Wall

all: $(BIN)

$(BIN): $(OBJ) cpu/libz80cpu.a

cpu/libz80cpu.a:
	make -C cpu

clean:
	make -C cpu clean
	rm -f *.o *~ $(BIN)

