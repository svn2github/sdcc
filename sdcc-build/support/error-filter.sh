# Ignore Makefile.dep/main.dep warnings
\.dep: No such file or directory
# Inhibit warnings from the z80 linker
^lk.+\.c:
# Inhibit warnings from the z80 assembler
^z80adr\.c:
^as.+\.c:
# Inhibit the warning from yacc
^conflicts:
# Inhibit Makefile autogeneration skew message.  Don't understand this one.
warning:  Clock skew detected
File .+ has modification time in the future