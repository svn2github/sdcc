#include <stdio.h>
#include <string.h>
#include "parse_map.h"
#include "disgb.h"

#define WREG 1
#define HREG 2
#define LREG 3
#define BREG 4
#define COND 5
#define BRST 8
#define WOP 6
#define BOP 7
#define XWREG 9
#define SBOP 10
#define BREL 11
#define SBIT 12


typedef struct smnemo mmnemo;
typedef struct smnemo *pmmnemo;

struct smnemo {
	char text[20];
	int op1;
	int op2;
};

typedef struct smnemo_exception mmnemo_exception;
typedef struct smnemo_exception *pmmnemo_exception;

struct smnemo_exception {
	char text[20];
	int op1;
	int op2;
	int opcode;
};

char byte_regs[][5] = {
	"B", "C", "D", "E", "H", "L", "(HL)", "A"
};

char word_regs[][3] = {
	"BC", "DE", "HL", "SP"
};

char conditions[][3] = {
	"NZ", "Z", "NC", "C"
};

mmnemo mnemo_80[] = {
	{ "LD\t%s,%s",		BREG,	BREG }
};

mmnemo mnemo_40[] = {
	{ "SPECIAL",		0,	0 },
	{ "LD\t%s,%s",		WREG,	WOP },
	{ "LD\t(%s),A",		WREG,	0 },
	{ "INC\t%s",		WREG,	0 },
	{ "INC\t%s",		HREG,	0 },
	{ "DEC\t%s",		HREG,	0 },
	{ "LD\t%s,%s",		HREG,	BOP },
	{ "SPECIAL",		0,	0 },
	{ "SPECIAL",		0,	0 },
	{ "ADD\tHL,%s",		WREG,	0 },
	{ "LD\tA,(%s)",		WREG,	0 },
	{ "DEC\t%s",		WREG,	0 },
	{ "INC\t%s",		LREG,	0 },
	{ "DEC\t%s",		LREG,	0 },
	{ "LD\t%s,%s",		LREG,	BOP }
};

mmnemo mnemo_07_40[] = {
	{ "RLCA",		0,	0 },
	{ "RRCA",		0,	0 },
	{ "RLA",		0,	0 },
	{ "RRA",		0,	0 },
	{ "DAA",		0,	0 },
	{ "CPL",		0,	0 },
	{ "SCF",		0,	0 },
	{ "CCF",		0,	0 }
};

mmnemo mnemo_C0[] = {
	{ "ADD\tA,%s",		BREG,	0 },
	{ "ADC\tA,%s",		BREG,	0 },
	{ "SUB\tA,%s",		BREG,	0 },
	{ "SBC\tA,%s",		BREG,	0 },
	{ "AND\t%s",		BREG,	0 },
	{ "XOR\t%s",		BREG,	0 },
	{ "OR\t%s",		BREG,	0 },
	{ "CP\t%s",		BREG,	0 }
};

mmnemo mnemo_FF[] = {
	{ "RET\t%s",		COND,	0 },
	{ "POP\t%s",		XWREG,	0 },
	{ "JP\t%s,%s",		COND,	WOP },
	{ "SPECIAL",		0,	0 },
	{ "CALL\t%s,%s",		COND,	WOP },
	{ "PUSH\t%s",		XWREG,	0 },
	{ "SPECIAL",		0,	0 },
	{ "RST\t%s",		BRST,	0 },
	{ "RET\t%s",		COND,	0 },
	{ "SPECIAL",		0,	0 },
	{ "JP\t%s,%s",		COND,	WOP },
	{ "CB ops",		0,	0 },
	{ "CALL\t%s,%s",		COND,	WOP },
	{ "SPECIAL",		0,	0 },
	{ "SPECIAL",		0,	0 },
	{ "RST\t%s",		BRST,	0 }
};

mmnemo mnemo_00_40[] = {
	{ "NOP",		0,	0 },
	{ "STOP",		BOP,	0 },
	{ "JR\t%s",		BREL,	0 },
	{ "JR\tNZ,%s",		BREL,	0 },
	{ "JR\tZ,%s",		BREL,	0 },
	{ "JR\tNC,%s",		BREL,	0 },
	{ "JR\tC,%s",		BREL,	0 }
};

mmnemo mnemo_CB_40[] = {
	{ "RLC\t%s",		BREG,	0 },
	{ "RRC\t%s",		BREG,	0 },
	{ "RL\t%s",		BREG,	0 },
	{ "RR\t%s",		BREG,	0 },
	{ "SLA\t%s",		BREG,	0 },
	{ "SRA\t%s",		BREG,	0 },
	{ "SWAP\t%s",		BREG,	0 },
	{ "SRL\t%s",		BREG,	0 },
};

mmnemo mnemo_CB_C7[] = {
	{ "BIT\t%s,%s",		SBIT,	BREG },
	{ "RES\t%s,%s",		SBIT,	BREG },
	{ "SET\t%s,%s",		SBIT,	BREG }
};

mmnemo_exception mnemo_exceptions_40[] = {
	{ "LDI\t(HL),A",		0,	0,	0x22 },
	{ "LDI\tA,(HL)",		0,	0,	0x2A },
	{ "LDD\t(HL),A",		0,	0,	0x32 },
	{ "LDD\tA,(HL)",		0,	0,	0x3A },
	{ "",			-1,	-1,	-1 }
};

mmnemo_exception mnemo_exceptions_FF[] = {
	{ "JP\t%s",		WOP,	0,	0xC3 },
	{ "ADD\tA,%s",		BOP,	0,	0xC6 },
	{ "RET",		0,	0,	0xC9 },
	{ "CALL\t%s",		WOP,	0,	0xCD },
	{ "ADC\tA,%s",		BOP,	0,	0xCE },
	{ "SUB\t%s",		BOP,	0,	0xD6 },
	{ "RETI",		0,	0,	0xD9 },
	{ "LD\t(FF00h+%s),A",	BOP,	0,	0xE0 },
	{ "LD\t(FF00h+C),A",	0,	0,	0xE2 },
	{ "AND\t%s",		BOP,	0,	0xE6 },
	{ "ADD\tSP,%s",		SBOP,	0,	0xE8 },
	{ "JP\t(HL)",		0,	0,	0xE9 },
	{ "LD\t(%s),A",		WOP,	0,	0xEA },
	{ "XOR\t%s",		BOP,	0,	0xEE },
	{ "LD\tA,(FF00h+%s)",	BOP,	0,	0xF0 },
	{ "POP\tAF",		0,	0,	0xF1 },
	{ "LD\tA,(C)",		0,	0,	0xF2 },
	{ "DI",			0,	0,	0xF3 },
	{ "PUSH\tAF",		0,	0,	0xF5 },
	{ "OR\t%s",		BOP,	0,	0xF6 },
	{ "LD\tHL,SP+%s",	SBOP,	0,	0xF8 },
	{ "LD\tSP,HL",		0,	0,	0xF9 },
	{ "LD\tA,(%s)",		WOP,	0,	0xFA },
	{ "EI",			0,	0,	0xFB },
	{ "CP\t%s",		BOP,	0,	0xFE },
	{ "",			-1,	-1,	-1 }
};

pmarea areas;
pmglobal sorted_globals;

int format_label( char *buffer, unsigned int addr )
{
	pmglobal walk;

	/* Try to find the label */
	walk = sorted_globals;
	
	while (walk) {
		if (walk->addr == addr) {
			strcpy( buffer, walk->name );
			return 0;
		}
		walk = walk->sorted_next;
	}
	sprintf( buffer, "%04X", addr );
	return -1;
}

int parse_label( char *buffer )
{
	pmglobal walk;
	int tmp;

	/* Try to find the label */
	walk = sorted_globals;
	
	while (walk) {
		if (!strcmp(walk->name, buffer )) {
			return walk->addr;
		}
		walk = walk->sorted_next;
	}
	/* No match - return hex value */
	if (sscanf( buffer, "%x", &tmp )==1) {
		return tmp;
	}
	return -1;
}
	
int format_operand( char *buffer, int op, int reg, UBYTE *base, int addr )
{
	switch (op) {
		case WREG:
			strcpy( buffer, word_regs[reg] );
			return 0;
		case XWREG:
			strcpy( buffer, word_regs[reg>>1] );
			return 0;
		case LREG:
			strcpy( buffer, byte_regs[(reg*2)+1] );
			return 0;
		case HREG:
			strcpy( buffer, byte_regs[(reg*2)] );
			return 0;
		case BREG:
			strcpy( buffer, byte_regs[reg] );
			return 0;
		case COND:
			strcpy( buffer, conditions[reg] );
			return 0;
		case BRST:
			sprintf( buffer,"%02X", (*base-0xc0)&0xf8);
			return 0;
		case SBOP:
			sprintf( buffer, "%i", (int)((signed char)base[1]) );
			return 1;
		case BREL:
			sprintf( buffer, "%04X", 2+addr+(int)((signed char)base[1]) );
			return 1;
		case SBIT:
			sprintf( buffer, "%u", reg );
			return 0;
		case BOP:
			sprintf( buffer, "%02X", base[1]);
			return 1;
		case WOP:
			format_label( buffer, base[1]|(((unsigned int)base[2])<<8));
			return 2;
		default:
			buffer[0] = '\0';
	}
	return 0;
}
			
int print_code( int offset, int reg1, int reg2, pmmnemo mnemo, UBYTE *base, int addr )
{
	char op1[40], op2[40];
	int total = 1;

	total += format_operand( op1, mnemo[offset].op1, reg1, base, addr );
	total += format_operand( op2, mnemo[offset].op2, reg2, base, addr );

	printf( mnemo[offset].text, op1, op2 );
	printf("\n");
	return total;
}

int handle_exception( UBYTE *base, pmmnemo_exception except, int addr )
{
	
	pmmnemo_exception walk_except;
	char op1[40], op2[40];
	int total;

	total = 0;

	walk_except = except;
	while ((walk_except->opcode!=-1)&&(!total)) {
		if (walk_except->opcode == *base ) {
			total =   1+format_operand( op1, walk_except->op1, 0, base, addr );
			total +=  format_operand( op2, walk_except->op2, 0, base, addr );

			printf( walk_except->text, op1, op2 );
			printf("\n");
		}
		walk_except++;
	}
	return total;
}
	
int disass( char *buffer, UBYTE *base, int addr )
{
	int sub;
	int op = *base;
	int tmp;
	char addr_name[50];
	
	if (format_label( addr_name, addr )==0) {
		printf("%s:\n", addr_name );
	}
	printf("%04X", addr );

	printf("\t");
	
	if (op<0x40) {
		sub = op & 0x0f;
		if ((sub&0x07)==0x07) {
			return print_code( op>>3, 0, 0, mnemo_07_40, base, addr );
		}
		else {
			if ((sub&0x07)==0x00) {
				return print_code( op>>3, 0, 0, mnemo_00_40, base, addr );
			}
			else {
				if (!(tmp=handle_exception( base, mnemo_exceptions_40, addr )))
					return print_code( op&0x0f, op>>4, 0, mnemo_40, base, addr );
				else
					return tmp;
			}
		}
	}
	else {
		op -=0x40;
		if (op<0x40) {		/* <0x80 */
			return print_code( 0, op>>3, op&0x07, mnemo_80, base, addr );
		}
		else {
			op-=0x040;
			if (op<0x40) {	/* <0xC0 */
				return print_code( op>>3, op&0x07, 0, mnemo_C0, base, addr );
			}
			else {
				if (*base==0x0cb) {
					/* Handle CB opcodes */
					base++;
					if (*base<0x40)
						return 1+print_code( *base>>3, *base&0x07, 0, mnemo_CB_40, base, addr );
					else
						return 1+print_code( (*base-0x40)>>6, (*base>>3)&0x07, *base&0x07, mnemo_CB_C7, base, addr );
				}
				else {
					
					/* Check to see if it's an exception to the rule */

					if (!(tmp=handle_exception( base, mnemo_exceptions_FF, addr ))) {
						/* Not an exception - handle normally */
						op-=0x40;
						return print_code( op&0x0f, op>>3, 0, mnemo_FF, base, addr );
					}
					else
						return tmp;
				}
			}
		}
	}
}

