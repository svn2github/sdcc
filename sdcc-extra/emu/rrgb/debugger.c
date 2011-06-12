#include "disgb.h"
#include "z80.h"
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include "debugger.h"

extern unsigned short callback_stack[100];
extern int callback_stack_pos;

void profile(void)
{
	pmfunction walk;
	char buffer[100];

	walk = fun_first;

	while (walk!=NULL) {
		format_label( buffer, walk->addr );
		printf("%s:\n"
		       "  Calls:\t%u\n"
		       "  tstates:\t%u\n"
		       "  avg:\t%u (%u%%)\n",
		       buffer,
		       walk->num_calls,
		       walk->tstates,
		       (walk->tstates)/(walk->num_calls),
		       (int)(100*walk->tstates/tstates)
		       );
		walk = walk->next;
	}
}
		
char *get_param( char *from, int *storein )
{
	char *end, tmp;
	
	/* Find the first real character */
	while (isspace(*from)&&(*from!='\0')) {
		from++;
	}

	if (*from =='\0')
		return NULL;
		
	end = from;
	/* Search till the end of the string */
	while (!isspace(*end)&&(*end!='\0')) {
		end++;
	}
	
	tmp = *end;
	*end='\0';
	*storein = parse_label(from);
	*end = tmp;
	return end;
}
	
int getparams( char *string, int *start, int *end, int pc, int defoffset )
{
	char *tmp;

	if ((tmp=get_param(&string[1],start))!=NULL) {
		if ((tmp=get_param(tmp, end))!=NULL) {
			return 2;
		}
		else {
			*end = *start+defoffset;
			return 1;
		}
	}
	else {
		*end = pc+defoffset;
		*start = pc;
		return 0;
	}
}

void show_callback_stack(void)
{
	int start, i;
	char buffer[100];

	start = callback_stack_pos-5;
	if (start<0)
		start = 0;
	for (i=start; i<callback_stack_pos; i++) {
		format_label( buffer, callback_stack[i] );
		printf("  %s\n", buffer );
	}
}
		
int setBreakpoint( unsigned int addr )
{
	int i;
	i=1;

	while ((i<5)&&(breakpoints[i]!=addr)) {
		i++;
	}

	if (i==5) {
		/* New breakpoint */
		i = 1;
		while ((i<5)&&(breakpoints[i]!=0))
			i++;
		if (i==5) {
			return -1;	/* Couldnt set */
		}
		breakpoints[i] = addr;
		return i;
	}
	return -2;
}

void printRegisters( pmregs regs )
{
	printf("BC = %02X%02X  DE = %02X%02X  HL = %02X%02X\n"
	       "A  = %02X    F  = %02X    PC = %04X\n"
	       "SP = %04X\n"
	       ,*regs->b, *regs->c, *regs->d, *regs->e, *regs->h, *regs->l,
	       *regs->a, *regs->f, *regs->pc,
	       *regs->sp
	       );
}

int clearBreakpoint( unsigned int addr )
{
	int i;
	i=1;

	while ((i<5)&&(breakpoints[i]!=addr))
		i++;
	if (i==5)
		return -1;
	breakpoints[i] = 0;
	return i;
}

int enterDebugger( pmregs regs )
{
	char string[100];
	unsigned char *ppc;
	unsigned int dpc = *regs->pc;
	int debugging, updateLine;
	int offset = 0;

	int start, end, dumpCount, i;

	debugging = 1;
	updateLine = 1;


	if (flags & DLIMITEDRUN) {
	  	printf("Error: Tried to enter the debugger in a limited length run\n");
		exit(-1);
	}

	while (debugging) {
		if (updateLine) {
			ppc = &mem[dpc];
			offset = disass( NULL, ppc, dpc );
/*			printf("%4X: %s\n", dpc, string );*/

			updateLine = 0;
		}
		printf("!: ");
		fflush(stdout);
		if (fgets( string, sizeof(string), stdin ) == NULL) {
			break;
		}
		switch (string[0]) {
			case 'd': {
				/* Dump: d [start] [end]
					If no end, end = start + 0x40
					If no start, use PC
				*/
				getparams( string, &start, &end, dpc, 0x10 );
				dumpCount = 0;
				while (start < end ) {
					if (dumpCount ==0) {
						printf("%4X: ", start);
					}
					printf(" %02X", mem[start++]);
					dumpCount++;
					if (dumpCount == 8)
						printf(" ");

					if (dumpCount == 16) {
						printf("  ");
						for (i=16; i>0; i--) {
							if (isprint(mem[start-i])) {
								printf("%c", mem[start-i]);
							}
							else
								printf(".");
						}
						printf("\n");
						dumpCount = 0;
					}
				}
				if (dumpCount!=0)
					printf("\n");

				break;
			}
			case 'r': {
				/* Registers */
				printRegisters( regs );
				break;
			}
#if DISABLED
			case 'f': {
				/* Print float in HLDE */
				printGBfloat((int)(*regs->h)<<8 |*regs->l, (int)(*regs->d)<<8 | (int)(*regs->e) );
				break;
			}
#endif
			case 'n': {
				/* Execute until next line */
				breakpoints[0] = dpc + offset;
				debugging = 0;
				break;
			};
			case 't': {
				/* Trace into (run one instruction) */
				return 1;
			};
			case 'g': {
				/* Continue */
				debugging = 0;
				break;
			}
			case 'q': {
				/* Quit */
				*regs->cpuRunning = 0;
				debugging = 0;
				break;
			};
			case 'b': {
				if (get_param( &string[1], &start)==NULL) {
					/* List breakpoints */
					for (end = 1; end <5; end++) {
						printf("Breakpoint %u at %04X\n", end, breakpoints[end]);
					}
				}
				else {
					end = setBreakpoint(start);
					switch (end) {
						case -1: {
							printf("Couldnt set breakpoint.\n");
							break;
						}
						case -2: {
							printf("Cleared breakpoint %i.\n", clearBreakpoint( start ));
							break;
						}
						default: {
							printf("Set breakpoint %u to %04X.\n", end, start);
						}
					}
				}
				break;
			}

			case 'u': {
				/* Unassemble: u [start] [end]
					If no end, end = start + 0x8
					If no start, start = pc
				*/
				getparams( string, &start, &end, dpc, 0x8 );
				ppc = &mem[start];
				while (start < end) {
					offset=disass( NULL, ppc, start );
					start += offset;
					ppc +=offset;
				}
				break;
			}
			case 's': {
				show_callback_stack();
				break;
			}
			case '?': {
				printf("unassemble	u [start] [end]\n"
				       "dump range	d [start] [end]\n"
				       "quit		q\n"
				       "help		?\n"
				       "go		g\n"
				       "breakpoint	b addr\n"
				       "show registers  r\n"
				       "go until next	n\n"
				       "trace into	t\n"
				       "stack		s\n"
					   "fp hlde     f\n"
				      );
				break;
			}

			default: {
				printf("?\n");
				break;
			}
		}
	}
	return 0;
}
