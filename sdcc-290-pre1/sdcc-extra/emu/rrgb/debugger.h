#ifndef __DEBUGGER_H
#define __DEBUGGER_H

typedef struct sregs mregs;
typedef struct sregs *pmregs;

struct sregs {
	unsigned char *a, *f, *b, *c, *d, *e, *h, *l;
	unsigned short *pc, *sp;
	int *cpuRunning;
};

int enterDebugger( pmregs regs );
int getparams( char *string, int *start, int *end, int pc, int defoffset );
int setBreakpoint( unsigned int addr );
void printRegisters( pmregs regs );
int clearBreakpoint( unsigned int addr );

#endif
