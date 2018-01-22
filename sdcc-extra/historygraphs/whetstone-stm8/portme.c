#include <stdio.h>
#include <stdint.h>

#define PA_DDR	(*(volatile uint8_t *)0x5002)
#define PA_CR1	(*(volatile uint8_t *)0x5003)

#define CLK_DIVR	(*(volatile uint8_t *)0x50c6)
#define CLK_PCKENR1	(*(volatile uint8_t *)0x50c7)
#define CLK_PCKENR2	(*(volatile uint8_t *)0x50ca)

#define USART3_SR	(*(volatile uint8_t *)0x5240)
#define USART3_DR	(*(volatile uint8_t *)0x5241)
#define USART3_BRR1	(*(volatile uint8_t *)0x5242)
#define USART3_BRR2	(*(volatile uint8_t *)0x5243)
#define USART3_CR2	(*(volatile uint8_t *)0x5245)
#define USART3_CR3	(*(volatile uint8_t *)0x5246)

#define TIM1_CR1	(*(volatile uint8_t *)0x5250)
#define TIM1_CNTRH	(*(volatile uint8_t *)0x525e)
#define TIM1_CNTRL	(*(volatile uint8_t *)0x525f)
#define TIM1_PSCRH	(*(volatile uint8_t *)0x5260)
#define TIM1_PSCRL	(*(volatile uint8_t *)0x5261)

#define USART_CR2_TEN (1 << 3)
#define USART_CR3_STOP2 (1 << 5)
#define USART_CR3_STOP1 (1 << 4)
#define USART_SR_TXE (1 << 7)

void init(void)
{
	CLK_DIVR = 0x00; // Set the frequency to 16 MHz
	CLK_PCKENR2 |= 0x02; // Enable clock to timer

	// Configure timer
	// 1000 ticks per second
	TIM1_PSCRH = 0x3e;
	TIM1_PSCRL = 0x80;
	// Enable timer
	TIM1_CR1 = 0x01;

	CLK_PCKENR1 = 0xFF; // Enable peripherals

	PA_DDR = 0x08; // Put TX line on
	PA_CR1 = 0x08;

	USART3_CR2 = USART_CR2_TEN; // Allow TX & RX
	USART3_CR3 &= ~(USART_CR3_STOP1 | USART_CR3_STOP2); // 1 stop bit
	USART3_BRR2 = 0x03; USART3_BRR1 = 0x68; // 9600 baud
}

unsigned int clock(void)
{
	unsigned char h = TIM1_CNTRH;
	unsigned char l = TIM1_CNTRL;
	return((unsigned int)(h) << 8 | l);
}

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

