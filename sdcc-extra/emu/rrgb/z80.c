/* Emulation of the Z80 CPU with hooks into the other parts of Z81.
 * Copyright (C) 1994 Ian Collier.
 * Z81 changes (C) 1995 Russell Marks.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "z80.h"
#include "debugger.h"
#include "parse_map.h"
#include "disgb.h"

pmfunction fun_first;

unsigned short breakpoints[5];
unsigned short callback_stack[100];

int callback_stack_pos;
extern unsigned long tstates;

void push_callback( unsigned short addr )
{
	pmfunction walk;
	int done = 0;
	
	walk=fun_first;
	while ((walk!=NULL)&&(!done)) {
		if (walk->addr==addr) {
			walk->start = tstates;
			walk->num_calls++;
			done=1;
		}
		else
			walk = walk->next;
	}
	if (!done) {
		/* New one */
		walk=fun_first;
		fun_first=malloc(sizeof(mfunction));
		fun_first->next=walk;
		fun_first->num_calls=1;
		fun_first->tstates=0;
		fun_first->addr=addr;
		fun_first->start=tstates;
	}
	callback_stack[callback_stack_pos++] = addr;
}

void pop_callback(void)
{
	pmfunction walk;

	if (callback_stack_pos > 0) {
		callback_stack_pos--;
		walk=fun_first;
		while (walk) {
			if (walk->addr==callback_stack[callback_stack_pos]) {
				walk->tstates+=tstates- walk->start;
				walk = NULL;
			}
			else
				walk = walk->next;
		}
	}
}

int mainloop(int flags)
{
	unsigned char a, f, b, c, d, e, h, l;
	unsigned char r, i, iff1, iff2, im;
	unsigned short pc;
	unsigned short sp;
	extern unsigned long tstates;
	unsigned int radjust;
	unsigned char intsample;
	unsigned char op;
	int	states_until_timerint;
	unsigned long last_tstates;
	unsigned startTime = tstates;
	int cpuRunning = 1;
	clock_t max_run_time = clock() + CLOCKS_PER_SEC*30;
	unsigned run_time_check_mod = 0;

	int j, runOne = 0;

	struct sregs regs =
	{
	  &a, &f, &b, &c, &d, &e, &h, &l, &pc, &sp, &cpuRunning
	};
	a = f = b = c = d = e = h = l = i = r = iff1 = iff2 = im = 0;
	fun_first = NULL;
	sp = pc = 0;
	sp = 0xdfff;
	pc = 0x100;		/* GB start address */
	tstates = 0;
	last_tstates=0;
	callback_stack_pos = 0;
	states_until_timerint = 40000;

	for (j = 0; j < 5; j++)
		breakpoints[j] = 0;

	if (flags&DSTARTDEBUG)
		breakpoints[0] = 0x100;

	while (cpuRunning) {
		if (runOne) {
			if (enterDebugger(&regs))
				runOne = 1;
			else
				runOne = 0;
		}
		j = 0;
		while (j < 5) {
			if (breakpoints[j] == pc) {
				if (enterDebugger(&regs))
					runOne = 1;
				break;
			}
			j++;
		}
		op = fetch(pc);
		pc++;
		switch (op) {
#include "z80ops.c"
		default:
			printf("\nrrgb: warning - invalid opcode %02x at %04x.\n", op, pc - 1);
			enterDebugger(&regs);
			break;
		}
		if (flags&DTIMERINT) {
			states_until_timerint-=tstates-last_tstates;
			last_tstates=tstates;
			if (states_until_timerint<0) {
				states_until_timerint=40000;
				push2(pc);
				pc=0x50;
			}
		}
		if (flags&DLIMITEDRUN && (++run_time_check_mod) == 100) {
		  if (clock() > max_run_time) {
    		    	printf("Error: Maximum runtime exceeded\n");
		  	cpuRunning = 0;
		  }
		  run_time_check_mod = 0;
		}
	}
	return 0;
}
