# Ignore Makefile.dep/main.dep warnings
\.dep: No such file or directory
# Inhibit the warning from yacc
^conflicts:
# Inhibit Makefile autogeneration skew message.  Don't understand this one.
warning:  Clock skew detected
File .+ has modification time in the future
# Inhibit mingw32 cross compile errors
^configure: error: can not run test program while cross compiling
^configure: error: ./configure failed for packihx
# Inhibit messages
^-- 