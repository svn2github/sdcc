// Source by Philipp Krause under CC0 1.0

// A "Hello, World!"-Program. We use it to make the board
// output something that can not be mistaken for output
// From a benchmark.

#include <stdint.h>
#include <stdio.h>

#define PD_DDR	(*(volatile uint8_t *)0x5011)
#define PD_CR1	(*(volatile uint8_t *)0x5012)

#define CLK_CKDIVR	(*(volatile uint8_t *)0x50c6)
#define CLK_PCKENR1	(*(volatile uint8_t *)0x50c7)

#define USART3_SR	(*(volatile uint8_t *)0x5240)
#define USART3_DR	(*(volatile uint8_t *)0x5241)
#define USART3_BRR1	(*(volatile uint8_t *)0x5242)
#define USART3_BRR2	(*(volatile uint8_t *)0x5243)
#define USART3_CR2	(*(volatile uint8_t *)0x5245)
#define USART3_CR3	(*(volatile uint8_t *)0x5246)

#define USART_CR2_TEN (1 << 3)
#define USART_CR3_STOP2 (1 << 5)
#define USART_CR3_STOP1 (1 << 4)
#define USART_SR_TXE (1 << 7)

#if defined(__CSMC__) // Cosmic weirdness
char putchar(char c)
{
        while(!(USART3_SR & USART_SR_TXE));

        USART3_DR = c;
        
        return c;
}
#elif defined(__RCSTM8__) // Raisonance weirdness
int putchar(char c)
{
	while(!(USART3_SR & USART_SR_TXE));

	USART3_DR = c;

	return(c);
}
#elif defined(__SDCC) && __SDCC_REVISION < 9624 // Old SDCC weirdness
void putchar(char c)
{
  	while(!(USART3_SR & USART_SR_TXE));

	USART3_DR = c;
}
#else // Standard C
int putchar(int c)
{
	while(!(USART3_SR & USART_SR_TXE));

	USART3_DR = c;

	return(c);
}
#endif

void main(void)
{
	unsigned long i = 0;

	CLK_CKDIVR = 0x00; // Set the frequency to 16 MHz
	CLK_PCKENR1 = 0xFF; // Enable peripherals

	PD_DDR = 0x20; // Put TX line on
	PD_CR1 = 0x20;

	USART3_CR2 = USART_CR2_TEN; // Allow TX and RX
	USART3_CR3 &= ~(USART_CR3_STOP1 | USART_CR3_STOP2); // 1 stop bit
	USART3_BRR2 = 0x03; USART3_BRR1 = 0x68; // 9600 baud

	for(;;)
	{
		printf("Hello, World!\n");
		for(i = 0; i < 147456; i++); // Sleep
	}
}

