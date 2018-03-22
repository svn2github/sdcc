// Source by Philipp Krause under CC0 1.0

// A "Hello, World!"-Program. We use it to make the board
// output something that can not be mistaken for output
// From a benchmark.

#include <stdio.h>

#include <C8051F120.h>

int putchar(int c)
{
	while(!(SCON0 & 0x02));
	SCON0 &= ~0x02;
	SBUF0 = c;
	return (c);
}

unsigned char _sdcc_external_startup(void)
{
	// Disable watchdog timer
	WDTCN = 0xde;
	WDTCN = 0xad;

	return 0; // perform normal initialization
}

void main(void)
{
	unsigned long int i = 0;

	// Initialize I/O pins
	SFRPAGE = 0xf;
	XBR0 = 0x04;				// UART0 on P0.0 and P0.1
	P0MDOUT = 0x01;				// Set port P0.0 (Uart tx) to push-pull
	XBR2 = 0x40;				// Enable crossbar

	OSCICN = 0xc3;				// Run at full 24.5 Mhz - gives better accuracy for baudrate

	// Use PLL to get SYSCLK to 98 Mhz to get reliable 9800 baud
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

	// Configure UART for 1200 baud, 8 data bits, 1 stop bit.
	SFRPAGE = 0x0;
	TMOD = 0x21;
	SCON0 = 0x40;
	TH1 = 203;
	TCON |= 0x40;
	SCON0 |= 0x02;				// Tell putchar() the UART is ready to send.

	for(;;)
	{
		printf("Hello, World!\n");
		for(i = 0; i < 147456; i++); // Sleep
	}
}

