/* Disassemble AVR instructions.
   Copyright (C) 1999
   Paulo Soares (psoares@consiste.pt)
   Denis Chertykov <denisc@overta.ru>

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */


#include "dis-asm.h"
#include "opintl.h"

typedef unsigned char u8;
typedef unsigned short u16;
typedef unsigned long u32;

#define IFMASK(a,b)     ((opcode & (a)) == (b))
#define CODE_MAX        65537

static char* SREG_flags = "CZNVSHTI";
static char* sect94[] = {"COM","NEG","SWAP","INC","NULL","ASR","LSR","ROR",
			 0,0,"DEC",0,0,0,0,0};
static char* sect98[] = {"CBI","SBIC","SBI","SBIS"};
static char* branchs[] = {
  "BRCS","BREQ","BRMI","BRVS",
  "BRLT","BRHS","BRTS","BRIE",
  "BRCC","BRNE","BRPL","BRVC",
  "BRGE","BRHC","BRTC","BRID"
};
static char* last4[] = {"BLD","BST","SBRC","SBRS"};



static void
dispLDD(u16 opcode, char* dest)
{
  opcode = (((opcode & 0x2000) >> 8) | ((opcode & 0x0c00) >> 7)
	    | (opcode & 7));
  sprintf(dest, "%d", opcode);
}

static void
regPP(u16 opcode, char* dest)
{
  opcode = ((opcode & 0x0600) >> 5) | (opcode & 0xf);
  sprintf(dest, "0x%02X", opcode);
}

static void
reg50(u16 opcode, char* dest)
{
  opcode = (opcode & 0x01f0) >> 4;
  sprintf(dest, "R%d", opcode);
}

static void
reg104(u16 opcode, char* dest)
{
  opcode = (opcode & 0xf) | ((opcode & 0x0200) >> 5);
  sprintf(dest, "R%d", opcode);
}

static void
reg40(u16 opcode, char* dest)
{
  opcode = (opcode & 0xf0) >> 4;
  sprintf(dest, "R%d", opcode + 16);
}

static void
reg20w(u16 opcode, char* dest)
{
  opcode = (opcode & 0x30) >> 4;
  sprintf(dest, "R%d", 24 + opcode * 2);
}

static void
lit404(u16 opcode, char* dest)
{
  opcode = ((opcode & 0xf00) >> 4) | (opcode & 0xf);
  sprintf(dest, "0x%02X", opcode);
}

static void
lit204(u16 opcode, char* dest)
{
  opcode = ((opcode & 0xc0) >> 2) | (opcode & 0xf);
  sprintf(dest, "0x%02X", opcode);
}

static void
add0fff(u16 op, char* dest, int PC)
{
  struct {int code:12;} opcode;
  PC += 2;
  opcode.code = op & 0x0fff;
  sprintf(dest, ".%+-8d ; 0x%06X", opcode.code * 2, PC + opcode.code * 2);
}

static void
add03f8(u16 op, char* dest, int PC)
{
  struct {
    int code:7;
  } opcode;
  PC += 2;
  opcode.code = op>>3;
  sprintf(dest, ".%+-8d ; 0x%06X", opcode.code * 2, PC + opcode.code * 2);
}

static u16
avrdis_opcode (addr, info)
     bfd_vma addr;
     disassemble_info *info;
{
  bfd_byte buffer[2];
  int status;
  status = info->read_memory_func(addr, buffer, 2, info);
  if (status != 0) 
    {
      info->memory_error_func(status, addr, info);
      return -1;
    }
  return bfd_getl16 (buffer);
}


int
print_insn_avr(addr, info)
     bfd_vma addr;
     disassemble_info *info;
{
  char rr[200];
  char rd[200];
  u16 opcode;
  void *stream = info->stream;
  fprintf_ftype func = info->fprintf_func;
  int cmd_len = 2;

  opcode = avrdis_opcode (addr, info);
  
  if (IFMASK(0xd000, 0x8000))
    {
      char letter;
      reg50(opcode, rd);
      dispLDD(opcode, rr);
      if (opcode & 8)
	letter = 'Y';
      else
	letter = 'Z';
      if (opcode & 0x0200)
	func (stream, "    STD     %c+%s,%s", letter, rr, rd);
      else
	func (stream, "    LDD     %s,%c+%s", rd, letter, rr);
    }
  else
    {
      switch (opcode & 0xf000)
        {
        case 0x0000:
	  {
	    reg50(opcode, rd);
	    reg104(opcode, rr);
	    switch (opcode & 0x0c00)
	      {
	      case 0x0000:
		func (stream, "    NOP");
		break;
	      case 0x0400:
		func (stream, "    CPC     %s,%s", rd, rr);
		break;
	      case 0x0800:
		func (stream, "    SBC     %s,%s", rd, rr);
		break;
	      case 0x0c00:
		func (stream, "    ADD     %s,%s", rd, rr);
		break;
	      }
	  }
	  break;
        case 0x1000:
	  {
	    reg50(opcode, rd);
	    reg104(opcode, rr);
	    switch (opcode & 0x0c00)
	      {
	      case 0x0000:
		func (stream, "    CPSE    %s,%s", rd, rr);
		break;
	      case 0x0400:
		func (stream, "    CP      %s,%s", rd, rr);
		break;
	      case 0x0800:
		func (stream, "    SUB     %s,%s", rd, rr);
		break;
	      case 0x0c00:
		func (stream, "    ADC     %s,%s", rd, rr);
		break;
	      }
	  }
	  break;
        case 0x2000:
	  {
	    reg50(opcode, rd);
	    reg104(opcode, rr);
	    switch (opcode & 0x0c00)
	      {
	      case 0x0000:
		func (stream, "    AND     %s,%s", rd, rr);
		break;
	      case 0x0400:
		func (stream, "    EOR     %s,%s", rd, rr);
		break;
	      case 0x0800:
		func (stream, "    OR      %s,%s", rd, rr);
		break;
	      case 0x0c00:
		func (stream, "    MOV     %s,%s", rd, rr);
		break;
	      }
	  }
	  break;
        case 0x3000:
	  {
	    reg40(opcode, rd);
	    lit404(opcode, rr);
	    func (stream, "    CPI     %s,%s", rd, rr);
	  }
	  break;
        case 0x4000:
	  {
	    reg40(opcode, rd);
	    lit404(opcode, rr);
	    func (stream, "    SBCI    %s,%s", rd, rr);
	  }
	  break;
        case 0x5000:
	  {
	    reg40(opcode, rd);
	    lit404(opcode, rr);
	    func (stream, "    SUBI    %s,%s", rd, rr);
	  }
	  break;
        case 0x6000:
	  {
	    reg40(opcode, rd);
	    lit404(opcode, rr);
	    func (stream, "    ORI     %s,%s", rd, rr);
	  }
	  break;
        case 0x7000:
	  {
	    reg40(opcode, rd);
	    lit404(opcode, rr);
	    func (stream, "    ANDI    %s,%s", rd, rr);
	  }
	  break;
        case 0x9000:
	  {
	    switch (opcode & 0x0e00)
	      {
	      case 0x0000:
		{
		  reg50(opcode, rd);
		  switch (opcode & 0xf)
		    {
		    case 0x0:
		      {
			func (stream, "    LDS     %s,0x%04X", rd,
			       avrdis_opcode(addr + 2, info));
			cmd_len = 4;
		      }
		      break;
		    case 0x1:
		      {
			func (stream, "    LD      %s,Z+", rd);
		      }
		      break;
		    case 0x2:
		      {
			func (stream, "    LD      %s,-Z", rd);
		      }
		      break;
		    case 0x9:
		      {
			func (stream, "    LD      %s,Y+", rd);
		      }
		      break;
		    case 0xa:
		      {
			func (stream, "    LD      %s,-Y", rd);
		      }
		      break;
		    case 0xc:
		      {
			func (stream, "    LD      %s,X", rd);
		      }
		      break;
		    case 0xd:
		      {
			func (stream, "    LD      %s,X+", rd);
		      }
		      break;
		    case 0xe:
		      {
			func (stream, "    LD      %s,-X", rd);
		      }
		      break;
		    case 0xf:
		      {
			func (stream, "    POP     %s", rd);
		      }
		      break;
		    default:
		      {
			func (stream, "    ????");
		      }
		      break;
		    }
		}
		break;
	      case 0x0200:
		{
		  reg50(opcode, rd);
		  switch (opcode & 0xf)
		    {
		    case 0x0:
		      {
			func (stream, "    STS     0x%04X,%s",
			       avrdis_opcode(addr + 2, info), rd);
			cmd_len = 4;
		      }
		      break;
		    case 0x1:
		      {
			func (stream, "    ST      Z+,%s", rd);
		      }
		      break;
		    case 0x2:
		      {
			func (stream, "    ST      -Z,%s", rd);
		      }
		      break;
		    case 0x9:
		      {
			func (stream, "    ST      Y+,%s", rd);
		      }
		      break;
		    case 0xa:
		      {
			func (stream, "    ST      -Y,%s", rd);
		      }
		      break;
		    case 0xc:
		      {
			func (stream, "    ST      X,%s", rd);
		      }
		      break;
		    case 0xd:
		      {
			func (stream, "    ST      X+,%s", rd);
		      }
		      break;
		    case 0xe:
		      {
			func (stream, "    ST      -X,%s", rd);
		      }
		      break;
		    case 0xf:
		      {
			func (stream, "    PUSH    %s", rd);
		      }
		      break;
		    default:
		      {
			func (stream, "    ????");
		      }
		      break;
		    }
		}
		break;
	      case 0x0400:
		{
		  if (IFMASK(0x020c, 0x000c))
		    {
		      u32 k = ((opcode & 0x01f0) >> 3) | (opcode & 1);
		      k = (k << 16) | avrdis_opcode(addr + 2, info);
		      if (opcode & 0x0002)
			func (stream, "    CALL    0x%06X", k*2);
		      else
			func (stream, "    JMP     0x%06X", k*2);
		      cmd_len = 4;
		    }
		  else if (IFMASK(0x010f, 0x0008))
		    {
		      int sf = (opcode & 0x70) >> 4;
		      if (opcode & 0x0080)
			func (stream, "    CL%c", SREG_flags[sf]);
		      else
			func (stream, "    SE%c", SREG_flags[sf]);
		    }
		  else if (IFMASK(0x000f, 0x0009))
		    {
		      if (opcode & 0x0100)
			func (stream, "    ICALL");
		      else
			func (stream, "    IJMP");
		    }
		  else if (IFMASK(0x010f, 0x0108))
		    {
		      if (IFMASK(0x0090, 0x0000))
			func (stream, "    RET");
		      else if (IFMASK(0x0090, 0x0010))
			func (stream, "    RETI");
		      else if (IFMASK(0x00e0, 0x0080))
			func (stream, "    SLEEP");
		      else if (IFMASK(0x00e0, 0x00a0))
			func (stream, "    WDR");
		      else if (IFMASK(0x00f0, 0x00c0))
			func (stream, "    LPM");
		      else if (IFMASK(0x00f0, 0x00d0))
			func (stream, "    ELPM");
		      else
			func (stream, "    ????");
		    }
		  else
		    {
		      const char* p;
		      reg50(opcode, rd);
		      p = sect94[opcode & 0xf];
		      if (!p)
			p = "????";
		      func (stream, "    %-8s%s", p, rd);
		    }
		}
		break;
	      case 0x0600:
		{
		  if (opcode & 0x0200)
		    {
		      lit204(opcode, rd);
		      reg20w(opcode, rr);
		      if (opcode & 0x0100)
			func (stream, "    SBIW    %s,%s", rr, rd);
		      else
			func (stream, "    ADIW    %s,%s", rr, rd);
		    }
		}
		break;
	      case 0x0800:
	      case 0x0a00:
		{
		  func (stream, "    %-8s0x%02X,%d",
			 sect98[(opcode & 0x0300) >> 8],
			 (opcode & 0xf8) >> 3,
			 opcode & 7);
		}
		break;
	      default:
		{
		  reg50(opcode, rd);
		  reg104(opcode, rr);
		  func (stream, "    MUL     %s,%s", rd, rr);
		}
	      }
	  }
	  break;
        case 0xb000:
	  {
	    reg50(opcode, rd);
	    regPP(opcode, rr);
	    if (opcode & 0x0800)
	      func (stream, "    OUT     %s,%s", rr, rd);
	    else
	      func (stream, "    IN      %s,%s", rd, rr);
	  }
	  break;
        case 0xc000:
	  {
	    add0fff(opcode, rd, addr);
	    func (stream, "    RJMP    %s", rd);
	  }
	  break;
        case 0xd000:
	  {
	    add0fff(opcode, rd, addr);
	    func (stream, "    RCALL   %s", rd);
	  }
	  break;
        case 0xe000:
	  {
	    reg40(opcode, rd);
	    lit404(opcode, rr);
	    func (stream, "    LDI     %s,%s", rd, rr);
	  }
	  break;
        case 0xf000:
	  {
	    if (opcode & 0x0800)
	      {
		reg50(opcode, rd);
		func (stream, "    %-8s%s,%d",
		       last4[(opcode & 0x0600) >> 9],
		       rd, opcode & 7);
	      }
	    else
	      {
		char* p;
		add03f8(opcode, rd, addr);
		p = branchs[((opcode & 0x0400) >> 7) | (opcode & 7)];
		func (stream, "    %-8s%s", p, rd);
	      }
	  }
	  break;
        }
    }
  return cmd_len;
}

