/* Emulations of the Z80 CPU instruction set - part of xz80.
 * Copyright (C) 1994 Ian Collier.
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

/* PENDING: Forward definitions. */
void handleRST08(struct sregs *pregs);

#define instr(opcode,cycles) case opcode: {tstates+=cycles
#define endinstr             }; break

enum {
  /** Carry */
  CBIT = 0x01,
  NBIT = 0x02,
  /** Parity/Overflow */
  VBIT = 0x04,
  /** Half carry */
  HBIT = 0x10,
  /** Zero */
  ZBIT = 0x40,
  /** Sign */
  SBIT = 0x80
};

enum {
  /** Carry */
  CLOG = 0,
  NLOG = 1,
  /** Parity/Overflow */
  VLOG = 2,
  /** Half carry */
  HLOG = 4,
  /** Zero */
  ZLOG = 6,
  /** Sign */
  SLOG = 7
};

#define cy (f&1)

#define xh (h)
#define xl (l)

#define setxh(x) (h=(x))
#define setxl(x) (l=(x))
#define inc(var) /* 8-bit increment */ ( var++,\
                                         f=(f&1)|(var&0xa8)|\
                                           ((!(var&15))<<4)|((!var)<<6)|\
                                           ((var==128)<<2)\
                                       )
#define dec(var) /* 8-bit decrement */ ( f=(f&1)|((!(var&15))<<4)|2,\
                                         --var,\
                                         f|=(var&0xa8)|((var==127)<<2)|\
                                            ((!var)<<6)\
                                       )
#define swap(x,y) {unsigned char t=x; x=y; y=t;}
#define addhl(hi,lo) /* 16-bit add */ do {\
                      unsigned short t;\
                      l=t=l+(lo);\
                      f=(f&0xc4)|(((t>>=8)+(h&0x0f)+((hi)&0x0f)>15)<<4);\
                      h=t+=h+(hi);\
                      f|=(h&0x28)|(t>>8); } while(0)

#define adda(x,c) /* 8-bit add */ do{unsigned short y;\
                      unsigned char z=(x);\
                      y=a+z+(c);\
                      f=(y&0xa8)|(y>>8)|(((a&0x0f)+(z&0x0f)+(c)>15)<<4)|\
                        (((~a^z)&0x80&(y^a))>>5);\
                      f|=(!(a=y))<<6;\
                   } while(0)
#define suba(x,c) /* 8-bit subtract */ do{unsigned short y;\
                      unsigned char z=(x);\
                      y=(a-z-(c))&0x1ff;\
                      f=(y&0xa8)|(y>>8)|(((a&0x0f)<(z&0x0f)+(c))<<4)|\
                        (((a^z)&0x80&(y^a))>>5)|2;\
                      f|=(!(a=y))<<6;\
                   } while(0)
#define cpa(x) /* 8-bit compare */ do{unsigned short y;\
                      unsigned char z=(x);\
                      y=(a-z)&0x1ff;\
                      f=(y&0xa8)|(y>>8)|(((a&0x0f)<(z&0x0f))<<4)|\
                        (((a^z)&0x80&(y^a))>>5)|2|((!y)<<6);\
                   } while(0)
#define anda(x) /* logical and */ do{\
                      a&=(x);\
                      f=(a&0xa8)|((!a)<<6)|0x10;\
                   } while(0)
#define xora(x) /* logical xor */ do{\
                      a^=(x);\
                      f=(a&0xa8)|((!a)<<6);\
                   } while(0)
#define ora(x) /* logical or */ do{\
                      a|=(x);\
                      f=(a&0xa8)|((!a)<<6);\
                   } while(0)

#define jr /* execute relative jump */ do{int j=(signed char)fetch(pc);\
                      pc+=j+1;\
                   } while(0)
#define jp /* execute jump */ (pc=fetch2(pc))
#define call /* execute call */ do{\
                      push2(pc+2);\
			if (flags&DPROFILE) \
				push_callback(fetch2(pc));\
                      jp;\
                   } while(0)
#define ret /* execute return */ do{\
			if (flags&DPROFILE) \
				pop_callback();\
                      pop2(pc);\
                   } while(0)
#define pop2(var) /* pop 16-bit register */ (var=fetch2(sp),sp+=2)
#define pop1(v1,v2) /* pop register pair */ (v2=fetch(sp),\
                                             v1=fetch(sp+1),sp+=2)
#define push2(val) /* push 16-bit register */ do{sp-=2;store2(sp,(val));}\
                                              while(0)
#define push1(v1,v2) /* push register pair */ do{sp-=2;\
                                                 store2b(sp,v1,v2);\
                                              }while(0)

instr(0,4);
   /* nop */
endinstr;

instr(1,12);
   c=fetch(pc),pc++;
   b=fetch(pc),pc++;
endinstr;

instr(2,8);
   store(bc,a);
endinstr;

instr(3,8);
   if(!++c)b++;
endinstr;

instr(4,4);
   inc(b);
endinstr;

instr(5,4);
   dec(b);
endinstr;

instr(6,8);
   b=fetch(pc),pc++;
endinstr;

instr(7,4);
   a=(a<<1)|(a>>7);
   f=(f&0xc4)|(a&0x29);
endinstr;

instr(8,20);			/* Old Ex AF,AF' - new LD (nnnn),SP NYT */
	{
		unsigned addr=fetch2(pc);
		store2(addr,sp);
		pc+=2;
	}
endinstr;

instr(9,8);
   addhl(b,c);
endinstr;

instr(10,8);
   a=fetch(bc);
endinstr;

instr(11,8);
   if(!c--)b--;
endinstr;

instr(12,4);
   inc(c);
endinstr;

instr(13,4);
   dec(c);
endinstr;

instr(14,8);
   c=fetch(pc),pc++;
endinstr;

instr(15,4);
   f=(f&0xc4)|(a&1);
   a=(a>>1)|(a<<7);
   f|=a&0x28;
endinstr;

instr(16,4);			/* Old DJNZ - new STOP (taken as abort) */
/*   if(!--b)pc++;
   else jr;*/
	cpuRunning=0;
endinstr;

instr(17,12);
   e=fetch(pc),pc++;
   d=fetch(pc),pc++;
endinstr;

instr(18,8);
   store(de,a);
endinstr;

instr(19,8);
   if(!++e)d++;
endinstr;

instr(20,4);
   inc(d);
endinstr;

instr(21,4);
   dec(d);
endinstr;

instr(22,8);
   d=fetch(pc),pc++;
endinstr;

instr(23,4);
  {int t=a>>7;
   a=(a<<1)|(f&1);
   f=(f&0xc4)|(a&0x28)|t;
  }
endinstr;

instr(24,8);
   jr;
endinstr;

instr(25,8);
   addhl(d,e);
endinstr;

instr(26,8);
   a=fetch(de);
endinstr;

instr(27,8);
   if(!e--)d--;
endinstr;

instr(28,4);
   inc(e);
endinstr;

instr(29,4);
   dec(e);
endinstr;

instr(30,8);
   e=fetch(pc),pc++;
endinstr;

instr(31,4);
  {int t=a&1;
   a=(a>>1)|(f<<7);
   f=(f&0xc4)|(a&0x28)|t;
  }
endinstr;

instr(32,8);
  if(f&0x40)pc++;
  else jr;
endinstr;

instr(33,12);
      l=fetch(pc),pc++;
      h=fetch(pc),pc++;
endinstr;

instr(34,8);		/* LD (HL+),A */
	store(hl,a);
	if(!++l)h++;
endinstr;

instr(35,8);		/* INC HL */
   if(!++l)h++;
endinstr;

instr(36,4);
   inc(h);
endinstr;

instr(37,4);
   dec(h);
endinstr;

instr(38,8);
   setxh(fetch(pc));
   pc++;
endinstr;

instr(39,4);
   {
      unsigned char incr=0, carry=cy;
      if((f&0x10) || (a&0x0f)>9) incr=6;
      if((f&1) || (a>>4)>9) incr|=0x60;
      if(f&2)suba(incr,0);
      else {
         if(a>0x90 && (a&15)>9)incr|=0x60;
         adda(incr,0);
      }
      f=((f|carry)&0xfb);
   }
endinstr;

instr(40,8);
   if(f&0x40)jr;
   else pc++;
endinstr;

instr(41,8);
   addhl(h,l);
endinstr;

instr(0x2A,8);		/* LD A,(HL+) */
	a=fetch(hl);
	if (!++l)h++;
endinstr;

instr(43,8);			/* DEC HL */
   if(!l--)h--;
endinstr;

instr(44,4);
   inc(l);
endinstr;

instr(45,4);
	dec(l);
endinstr;

instr(46,8);
   setxl(fetch(pc));
   pc++;
endinstr;

instr(47,4);
   a=~a;
   f=(f&0xc5)|(a&0x28)|0x12;
endinstr;

instr(0x030,8);
   if(f&1)pc++;
   else jr;
endinstr;

instr(49,12);
   sp=fetch2(pc);
   pc+=2;
endinstr;

instr(50,8);			/* LD (HL-),A */
	store(hl,a);
	if(!l--)h--;
endinstr;

instr(51,8);
   sp++;
endinstr;

instr(52,12);
  {unsigned char t=fetch(hl);
   inc(t);
   store(hl,t);
  }
endinstr;

instr(53,12);
  {unsigned char t=fetch(hl);
   dec(t);
   store(hl,t);
  }
endinstr;

instr(54,12);
   store(hl,fetch(pc));
   pc++;
endinstr;

instr(55,4);
   f=(f&0xc4)|1|(a&0x28);
endinstr;

instr(56,8);
   if(f&1)jr;
   else pc++;
endinstr;

instr(57,8);
   addhl((sp>>8),(sp&0xff));
endinstr;

instr(58,8);			/* LD A,(HL-) */
	a=fetch(hl);
	if(!l--)h--;
endinstr;

instr(59,8);
   sp--;
endinstr;

instr(60,4);
   inc(a);
endinstr;

instr(61,4);
   dec(a);
endinstr;

instr(62,8);
   a=fetch(pc),pc++;
endinstr;

instr(63,4);
   f=(f&0xc4)|(cy^1)|(cy<<4)|(a&0x28);
endinstr;

instr(0x40,4);
   /* ld b,b */
endinstr;

instr(0x41,4);
   b=c;
endinstr;

instr(0x42,4);
   b=d;
endinstr;

instr(0x43,4);
   b=e;
endinstr;

instr(0x44,4);
   b=xh;
endinstr;

instr(0x45,4);
   b=xl;
endinstr;

instr(0x46,8);
   b=fetch(hl);
endinstr;

instr(0x47,4);
   b=a;
endinstr;

instr(0x48,4);
   c=b;
endinstr;

instr(0x49,4);
   /* ld c,c */
endinstr;

instr(0x4a,4);
   c=d;
endinstr;

instr(0x4b,4);
   c=e;
endinstr;

instr(0x4c,4);
   c=xh;
endinstr;

instr(0x4d,4);
   c=xl;
endinstr;

instr(0x4e,8);
   c=fetch(hl);
endinstr;

instr(0x4f,4);
   c=a;
endinstr;

instr(0x50,4);
   d=b;
endinstr;

instr(0x51,4);
   d=c;
endinstr;

instr(0x52,4);
   /* ld d,d */
endinstr;

instr(0x53,4);
   d=e;
endinstr;

instr(0x54,4);
   d=xh;
endinstr;

instr(0x55,4);
   d=xl;
endinstr;

instr(0x56,8);
   d=fetch(hl);
endinstr;

instr(0x57,4);
   d=a;
endinstr;

instr(0x58,4);
   e=b;
endinstr;

instr(0x59,4);
   e=c;
endinstr;

instr(0x5a,4);
   e=d;
endinstr;

instr(0x5b,4);
   /* ld e,e */
endinstr;

instr(0x5c,4);
   e=xh;
endinstr;

instr(0x5d,4);
   e=xl;
endinstr;

instr(0x5e,8);
   e=fetch(hl);
endinstr;

instr(0x5f,4);
   e=a;
endinstr;

instr(0x60,4);
   setxh(b);
endinstr;

instr(0x61,4);
   setxh(c);
endinstr;

instr(0x62,4);
   setxh(d);
endinstr;

instr(0x63,4);
   setxh(e);
endinstr;

instr(0x64,4);
   /* ld h,h */
endinstr;

instr(0x65,4);
   setxh(xl);
endinstr;

instr(0x66,8);
   h=fetch(hl);
endinstr;

instr(0x67,4);
   setxh(a);
endinstr;

instr(0x68,4);
   setxl(b);
endinstr;

instr(0x69,4);
   setxl(c);
endinstr;

instr(0x6a,4);
   setxl(d);
endinstr;

instr(0x6b,4);
   setxl(e);
endinstr;

instr(0x6c,4);
   setxl(xh);
endinstr;

instr(0x6d,4);
   /* ld l,l */
endinstr;

instr(0x6e,8);
   l=fetch(hl);
endinstr;

instr(0x6f,4);
   setxl(a);
endinstr;

instr(0x70,8);
   store(hl,b);
endinstr;

instr(0x71,8);
   store(hl,c);
endinstr;

instr(0x72,8);
   store(hl,d);
endinstr;

instr(0x73,8);
   store(hl,e);
endinstr;

instr(0x74,8);
   store(hl,h);
endinstr;

instr(0x75,8);
   store(hl,l);
endinstr;

instr(0x76,4);
   /* no interrupt support, so effectively a nop */
endinstr;

instr(0x77,8);
   store(hl,a);
endinstr;

instr(0x78,4);
   a=b;
endinstr;

instr(0x79,4);
   a=c;
endinstr;

instr(0x7a,4);
   a=d;
endinstr;

instr(0x7b,4);
   a=e;
endinstr;

instr(0x7c,4);
   a=xh;
endinstr;

instr(0x7d,4);
   a=xl;
endinstr;

instr(0x7e,8);		/* LD A,(HL) */
   a=fetch(hl);
endinstr;

instr(0x7f,4);
   /* ld a,a */
endinstr;

instr(0x80,4);
   adda(b,0);
endinstr;

instr(0x81,4);
   adda(c,0);
endinstr;

instr(0x82,4);
   adda(d,0);
endinstr;

instr(0x83,4);
   adda(e,0);
endinstr;

instr(0x84,4);
   adda(xh,0);
endinstr;

instr(0x85,4);
   adda(xl,0);
endinstr;

instr(0x86,8);
   adda(fetch(hl),0);
endinstr;

instr(0x87,4);
   adda(a,0);
endinstr;

instr(0x88,4);
   adda(b,cy);
endinstr;

instr(0x89,4);
   adda(c,cy);
endinstr;

instr(0x8a,4);
   adda(d,cy);
endinstr;

instr(0x8b,4);
   adda(e,cy);
endinstr;

instr(0x8c,4);
   adda(xh,cy);
endinstr;

instr(0x8d,4);
   adda(xl,cy);
endinstr;

instr(0x8e,8);
   adda(fetch(hl),cy);
endinstr;

instr(0x8f,4);
   adda(a,cy);
endinstr;

instr(0x90,4);
   suba(b,0);
endinstr;

instr(0x91,4);
   suba(c,0);
endinstr;

instr(0x92,4);
   suba(d,0);
endinstr;

instr(0x93,4);
   suba(e,0);
endinstr;

instr(0x94,4);
   suba(xh,0);
endinstr;

instr(0x95,4);
   suba(xl,0);
endinstr;

instr(0x96,8);
   suba(fetch(hl),0);
endinstr;

instr(0x97,4);
   suba(a,0);
endinstr;

instr(0x98,4);
   suba(b,cy);
endinstr;

instr(0x99,4);
   suba(c,cy);
endinstr;

instr(0x9a,4);
   suba(d,cy);
endinstr;

instr(0x9b,4);
   suba(e,cy);
endinstr;

instr(0x9c,4);
   suba(xh,cy);
endinstr;

instr(0x9d,4);
   suba(xl,cy);
endinstr;

instr(0x9e,8);
   suba(fetch(hl),cy);
endinstr;

instr(0x9f,4);
   suba(a,cy);
endinstr;

instr(0xa0,4);
   anda(b);
endinstr;

instr(0xa1,4);
   anda(c);
endinstr;

instr(0xa2,4);
   anda(d);
endinstr;

instr(0xa3,4);
   anda(e);
endinstr;

instr(0xa4,4);
   anda(xh);
endinstr;

instr(0xa5,4);
   anda(xl);
endinstr;

instr(0xa6,8);
   anda(fetch(hl));
endinstr;

instr(0xa7,4);
   anda(a);
endinstr;

instr(0xa8,4);
   xora(b);
endinstr;

instr(0xa9,4);
   xora(c);
endinstr;

instr(0xaa,4);
   xora(d);
endinstr;

instr(0xab,4);
   xora(e);
endinstr;

instr(0xac,4);
   xora(xh);
endinstr;

instr(0xad,4);
   xora(xl);
endinstr;

instr(0xae,8);
   xora(fetch(hl));
endinstr;

instr(0xaf,4);
   xora(a);
endinstr;

instr(0xb0,4);
   ora(b);
endinstr;

instr(0xb1,4);
   ora(c);
endinstr;

instr(0xb2,4);
   ora(d);
endinstr;

instr(0xb3,4);
   ora(e);
endinstr;

instr(0xb4,4);
   ora(xh);
endinstr;

instr(0xb5,4);
   ora(xl);
endinstr;

instr(0xb6,8);
   ora(fetch(hl));
endinstr;

instr(0xb7,4);
   ora(a);
endinstr;

instr(0xb8,4);
   cpa(b);
endinstr;

instr(0xb9,4);
   cpa(c);
endinstr;

instr(0xba,4);
   cpa(d);
endinstr;

instr(0xbb,4);
   cpa(e);
endinstr;

instr(0xbc,4);
   cpa(xh);
endinstr;

instr(0xbd,4);
   cpa(xl);
endinstr;

instr(0xbe,8);
   cpa(fetch(hl));
endinstr;

instr(0xbf,4);
   cpa(a);
endinstr;

instr(0xc0,8);
   if(!(f&0x40))ret;
endinstr;

instr(0xc1,12);
   pop1(b,c);
endinstr;

instr(0xc2,12);
   if(!(f&0x40))jp;
   else pc+=2;
endinstr;

instr(0xc3,12);
   jp;
endinstr;

instr(0xc4,12);
   if(!(f&0x40))call;
   else pc+=2;
endinstr;

instr(0xc5,16);
   push1(b,c);
endinstr;

instr(0xc6,8);
   adda(fetch(pc),0);
   pc++;
endinstr;

instr(0xc7,32);		/* Old RST 00 - new End emulator */
/*   push2(pc);
   pc=0; */
	cpuRunning=0;
endinstr;

instr(0xc8,8);
   if(f&0x40)ret;
endinstr;

instr(0xc9,8);
   ret;
endinstr;

instr(0xca,12);
   if(f&0x40)jp;
   else pc+=2;
endinstr;

instr(0xcb,8);
#include "cbops.c"
endinstr;

instr(0xcc,12);
   if(f&0x40)call;
   else pc+=2;
endinstr;

instr(0xcd,12);
   call;
endinstr;

instr(0xce,8);
   adda(fetch(pc),cy);
   pc++;
endinstr;

instr(0xcf,32);			/* Old RST 08 - new print following string */
{
  handleRST08(&regs);
}
endinstr;

instr(0xd0,8);
   if(!cy)ret;
endinstr;

instr(0xd1,12);
   pop1(d,e);
endinstr;

instr(0xd2,12);
   if(!cy)jp;
   else pc+=2;
endinstr;

instr(0xd3,8);			/* Old OUT (nn),a */
/*   tstates+=out(a,fetch(pc),a);
   pc++; */
endinstr;

instr(0xd4,12);
   if(!cy)call;
   else pc+=2;
endinstr;

instr(0xd5,16);
   push1(d,e);
endinstr;

instr(0xd6,8);
   suba(fetch(pc),0);
   pc++;
endinstr;

instr(0xd7,32);			/* Old RST 10 */
   push2(pc);
   pc=16;
endinstr;

instr(0xd8,8);
   if(cy)ret;
endinstr;

instr(0xd9,8);			/* Old EXX - now RETI */
	ret;			/* xxx not what the GB really does */
endinstr;

instr(0xda,12);
   if(cy)jp;
   else pc+=2;
endinstr;

#ifdef INCLUDE_UNIMP
				/* Old IN A,(nn) */
/*instr(0xdb,8);
   {unsigned short t;
      a=t=in(a,fetch(pc));
      tstates+=t>>8;
      pc++;
   }
endinstr;*/
#endif

instr(0xdc,12);
   if(cy)call;
   else pc+=2;
endinstr;

#ifdef INCLUDE_UNIMP
				/* Old IX/IY commands */
/*instr(0xdd,4);			
endinstr;*/
#endif

instr(0xde,8);
   suba(fetch(pc),cy);		/* SBC A,nn */
   pc++;
endinstr;

instr(0xdf,32);			/* Old RST 18 - new start timing */
	startTime = tstates;
/*   push2(pc);
   pc=24;*/
endinstr;

#ifdef INCLUDE_UNIMP
instr(0xe0,12);			/* Old RET PO - now LD ($FF00+nn),A */
/*   if(!(f&4))ret; */
endinstr;
#endif

instr(0xe1,12);			/* POP HL */
   pop1(h,l);
endinstr;

#ifdef INCLUDE_UNIMP
instr(0xe2,8);			/* Old JP PO - now LD ($FF00+C),A */
/*   if(!(f&4))jp;
   else pc+=2; */
endinstr;
#endif

				/* Old EX (SP),HL */
/*instr(0xe3,19);			
   if(!ixoriy){
      unsigned short t=fetch2(sp);
      store2b(sp,h,l);
      l=t;
      h=t>>8;
   }
   else if(ixoriy==1){
      unsigned short t=fetch2(sp);
      store2(sp,ix);
      ix=t;
   }
   else{
      unsigned short t=fetch2(sp);
      store2(sp,iy);
      iy=t;
   } 
endinstr;*/

				/* Old CALL PO */
/*instr(0xe4,10);			
   if(!(f&4))call;
   else pc+=2; 
endinstr;*/

instr(0xe5,16);
   push1(h,l);
endinstr;

instr(0xe6,8);
   anda(fetch(pc));
   pc++;
endinstr;

instr(0xe7,32);			/* Old RST 20 - new print time */
/*   push2(pc);
   pc=32;*/
	printf("Time: %lu\n", tstates-startTime);
endinstr;

instr(0xe8,16);			/* Old RET PE - now ADD SP,shortint */
	sp+=(signed char)fetch(pc);
	pc++;
/*   if(f&4)ret; */
endinstr;

instr(0xe9,4);
   pc=hl;
endinstr;

instr(0xea,16);			/* Old JP PE - now LD (nnnn),A */
  {unsigned short addr=fetch2(pc);
   pc+=2;
   store(addr,a);
  }
endinstr;

				/* Old EX DE,HL */
/*instr(0xeb,4);
   swap(h,d);
   swap(e,l); 
endinstr;*/

				/* Old CALL PE */
/*instr(0xec,10); 		
   if(f&4)call;	
   else pc+=2;
endinstr;*/

				/* Old ED commands */
/*instr(0xed,4);		
endinstr;*/

instr(0xee,8);
   xora(fetch(pc));
   pc++;
endinstr;

instr(0xef,32);			/* Old RST 28 - new print float */
/*   push2(pc);
   pc=40;*/
endinstr;

#ifdef INCLUDE_UNIMP
instr(0xf0,12);			/* Old RET P - now LD A,($FF00+nn) NYI */
/*   if(!(f&0x80))ret; */
endinstr;
#endif

instr(0xf1,12);
   pop1(a,f);
endinstr;

#ifdef INCLUDE_UNIMP
instr(0xf2,8);			/* Old JP P - now LD A,(C) NYT */
	a=fetch(c);
/*   if(!(f&0x80))jp;
   else pc+=2; */
endinstr;
#endif

instr(0xf3,4);
   iff1=iff2=0;
   intsample=0;
endinstr;

				/* Old CALL P */
/*instr(0xf4,10);			
   if(!(f&0x80))call;
   else pc+=2;
endinstr;*/

instr(0xf5,16);
   push1(a,f);
endinstr;

instr(0xf6,8);
   ora(fetch(pc));
   pc++;
endinstr;

instr(0xf7,32);			/* Old RST 30 - new switch bank */
/*   push2(pc);
   pc=48;*/
   switchBank( a, hl );
endinstr;

instr(0xf8,12);			/* Old RET M - new LD HL,SP+nn NYT */
	{ 
		unsigned j = (unsigned)(sp+(signed char)fetch(pc));
		h=j>>8; l=j&0x0ff;
                /* Clear Z and N */
                f &= ~(ZBIT | NBIT | CBIT | HBIT);
                /* Set carry and half carry as appropriate */
                /* PENDING: Set half carry. */
                f |= (j>>8);
		pc++;
	}
/*   if(f&0x80)ret; */
endinstr;

instr(0xf9,8);
   sp=hl;
endinstr;

instr(0xfa,16);			/* Old JP M - new LD A,(nnnn) */
  {unsigned short addr=fetch2(pc);
   pc+=2;
   a=fetch(addr);
  }
/*   if(f&0x80)jp;
   else pc+=2; */
endinstr;

instr(0xfb,4);
   iff1=iff2=1;
   intsample=0;
endinstr;
				/* Old CALL M */
/*instr(0xfc,10);	
   if(f&0x80)call;
   else pc+=2; 
endinstr;*/

				/* Old IY prefix */
/*instr(0xfd,4);			
   new_ixoriy=2;
   intsample=0;
endinstr;*/

instr(0xfe,8);
   cpa(fetch(pc));
   pc++;
endinstr;

instr(0xff,32);			/* Old RST 38 - New system call */
/*   push2(pc);
pc=0x038;*/
	a=handle_sys(a,hl);
endinstr;

