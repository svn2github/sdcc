# Makefile for ConsoleZ80, a simple Console based Z80 EMU
SOURCE = Z80.java ConsoleZ80.java
VER = 0.1.0

OBJ = $(SOURCE:.java=.class)

JAVAC = javac -O

%.class: %.java
	$(JAVAC) $<

all: $(OBJ)

doc:
	mkdir -p html
	javadoc -d html $(SOURCE)

clean:
	rm -f *.class *~
