/* Target-specific functions for making Whetstone work on the STM8
   Author: Philipp Klaus Krause */

#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>

// #include <C8051F120.h> conflict with P0 and P3 from whetstone.c

__sfr __at(0xa2) _XPAGE;
__sfr __at(0x84) SFRPAGE;

__sfr __at(0xe1) XBR0; 
__sfr __at(0xe3) XBR2;
__sfr __at(0xff) WDTCN;
__sfr __at(0x8a) OSCICN;
__sfr __at(0xa8) IE;

__sfr __at(0xa4) P0MDOUT;
__sfr __at(0x88) TCON;
__sfr __at(0x89) TMOD;
__sfr __at(0x8a) TL0;
__sfr __at(0x8c) TH0;
__sfr __at(0x8d) TH1;
__sfr __at(0x98) SCON0;
__sfr __at(0x99) SBUF0;

__sfr __at(0xb7) FLSCL;

__sfr __at(0x89) PLL0CN;
__sfr __at(0x8e) PLL0MUL;
__sfr __at(0x8f) PLL0FLT;

__sfr __at(0x97) CLKSEL;

volatile unsigned long int clocktime;
volatile bool clockupdate;

void clockinc(void) __interrupt(1)
{
	TH0 = (65536 - 8167) / 256;
	TL0 = (65536 - 8167) % 256;
	clocktime++;
	clockupdate = true;
}

unsigned long int clock(void)
{
	unsigned long int ctmp;

	do
	{
		clockupdate = false;
		ctmp = clocktime;
	} while (clockupdate);
	
	return(ctmp);
}

unsigned char _sdcc_external_startup(void)
{
	// Disable watchdog timer
	WDTCN = 0xde;
	WDTCN = 0xad;

	return 0; // perform normal initialization
}

void init(void)
{
	unsigned char i;

	// Initialize I/O pins
	SFRPAGE = 0xf;
	XBR0 = 0x04;				// UART0 on P0.0 and P0.1
	P0MDOUT = 0x01;				// Set port P0.0 (Uart tx) to push-pull
	XBR2 = 0x40;				// Enable crossbar

	OSCICN = 0xc3;				// Run internal oscillator at full 24.5 Mhz

	// Use PLL to get SYSCLK to 98 Mhz for higher benchmark scores
	SFRPAGE = 0x0;
	FLSCL = 0xb0;
	SFRPAGE = 0xf;
	PLL0CN = 0x01;
	PLL0FLT = 0x01;
	PLL0MUL = 0x04;
	for (i = 0; i < 31; i++) // Wait 5 µs
        {
          __asm
          nop
          nop
          nop
          nop
          __endasm;
        }
	PLL0CN = 0x03;
	while (!(PLL0CN & 0x10));
	CLKSEL = 0x02;

	// Configure timer for 24.5 Mhz SYSCLK
	// 1000 ticks per second
	SFRPAGE = 0x0;
	TH0 = (65536 - 8167) / 256;
	TL0 = (65536 - 8167) % 256;
	TMOD = 0x01;
	IE |= 0x82;
	TCON |= 0x10; // Start timer

	// Configure UART for 4800 baud, 8 data bits, 1 stop bit.
	SFRPAGE = 0x0;
	TMOD = 0x21;
	SCON0 = 0x40;
	TH1 = 203;
	TCON |= 0x40;
	SCON0 |= 0x02;				// Tell putchar() the UART is ready to send.
}

#if __SDCC_REVISION >= 9624
int putchar(int c)
{
	while(!(SCON0 & 0x02));
	SCON0 &= ~0x02;
	SBUF0 = c;
	return (c);
}
#else
void putchar(char c)
{
	while(!(SCON0 & 0x02));
	SCON0 &= ~0x02;
	SBUF0 = c;
}
#endif

