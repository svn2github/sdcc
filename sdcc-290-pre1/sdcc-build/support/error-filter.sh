# Ignore Makefile.dep/main.dep warnings
\.dep: No such file or directory
# Inhibit the warning from yacc
# ^conflicts:
# Inhibit Makefile autogeneration skew message. SF's server (NFS!) are not synchronized despite of ntp.
warning:  Clock skew detected
File .+ has modification time in the future
# Inhibit mingw32 cross compile errors
# ^configure: error: can not run test program while cross compiling
# ^configure: error: ./configure failed for packihx
# ^configure: warning: Cannot determine the sizeof basic types while cross compiling. Using gcc on a 32 bit machine defaults.
# Inhibit messages
^-- 
# ^configure: WARNING:
# If a cross compiler is detected then cross compile mode will be used.
# Inhibit regression suite messages
^Processing
# for mcs-stack-auto
^\.\./\.\./device/lib/vprintf\.c:28:2: warning: #warning "this module cannot yet be use as a reentrant one"
# CVS warnings regarding locks
^cvs server: .* waiting for .* lock in /cvsroot/
^cvs server: .* obtained lock in /cvsroot/
# CVS retries
^cvs \[checkout aborted\]: 
^CVS failed .*: 
# regression tests
^gen/host/.*warning: integer overflow in expression
^gen/host/.*In function 