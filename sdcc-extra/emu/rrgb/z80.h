/* Miscellaneous definitions for xz80, copyright (C) 1994 Ian Collier.
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

#define Z80_quit  1
#define Z80_NMI   2
#define Z80_reset 3
#define Z80_load  4
#define Z80_save  5
#define Z80_log   6

#define SEG_SIZE 8192
#define NUM_SEGS (65536/SEG_SIZE)

#define DMAP		1
#define DPROFILE	2
#define DSTARTDEBUG	4
#define DSOCKETS	8
#define DTIMERINT	16
#define DLIMITEDRUN	32

#ifdef SEG
extern unsigned char *segments[];
extern char bank_file_name[];
void switchBank( int segment, unsigned bank );
#endif

void profile(void);

extern unsigned char mem[];
extern int memattr[];
extern int hsize,vsize;
extern volatile int interrupted;
extern int forceok;
extern unsigned short breakpoints[5];
extern unsigned long tstates;
extern int flags;

extern int mainloop(int flags);
int handle_sys(int scall, int parameter);

typedef struct sfunction mfunction;
typedef struct sfunction *pmfunction;

struct sfunction {
	int addr;
	int num_calls;
	int tstates;
	int start;
	pmfunction next;
};

extern pmfunction fun_first;

#define fetch(x) (mem[x])
#define fetch2(x) ((mem[x+1]<<8)|mem[x])

#define store( addr, value ) mem[addr]=value;

#define store2b(addr,hi,lo) \
	mem[addr]=(lo);\
	mem[addr+1]=(hi);

#define store2(x,y) store2b(x,(y)>>8,(y)&255)

#ifdef __GNUC__
static void inline storefunc(unsigned short ad,unsigned char b){
   store(ad,b);
}

#undef store
#define store(x,y) storefunc(x,y)

static void inline store2func(unsigned short ad,unsigned char b1,unsigned char b2){
   store2b(ad,b1,b2);
}
#undef store2b
#define store2b(x,hi,lo) store2func(x,hi,lo)
#endif

#define bc ((b<<8)|c)
#define de ((d<<8)|e)
#define hl ((h<<8)|l)
