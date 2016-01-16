/*
 * This definitions of the PIC16F1615 MCU.
 *
 * This file is part of the GNU PIC library for SDCC, originally
 * created by Molnar Karoly <molnarkaroly@users.sf.net> 2016.
 *
 * This file is generated automatically by the cinc2h.pl, 2016-01-09 15:09:02 UTC.
 *
 * SDCC is licensed under the GNU Public license (GPL) v2. Note that
 * this license covers the code to the compiler and other executables,
 * but explicitly does not cover any code or objects generated by sdcc.
 *
 * For pic device libraries and header files which are derived from
 * Microchip header (.inc) and linker script (.lkr) files Microchip
 * requires that "The header files should state that they are only to be
 * used with authentic Microchip devices" which makes them incompatible
 * with the GPL. Pic device libraries and header files are located at
 * non-free/lib and non-free/include directories respectively.
 * Sdcc should be run with the --use-non-free command line option in
 * order to include non-free header files and libraries.
 *
 * See http://sdcc.sourceforge.net/ for the latest information on sdcc.
 */

#include <pic16f1615.h>

//==============================================================================

__at(0x0000) __sfr INDF0;

__at(0x0001) __sfr INDF1;

__at(0x0002) __sfr PCL;

__at(0x0003) __sfr STATUS;
__at(0x0003) volatile __STATUSbits_t STATUSbits;

__at(0x0004) __sfr FSR0;

__at(0x0004) __sfr FSR0L;

__at(0x0005) __sfr FSR0H;

__at(0x0006) __sfr FSR1;

__at(0x0006) __sfr FSR1L;

__at(0x0007) __sfr FSR1H;

__at(0x0008) __sfr BSR;
__at(0x0008) volatile __BSRbits_t BSRbits;

__at(0x0009) __sfr WREG;

__at(0x000A) __sfr PCLATH;

__at(0x000B) __sfr INTCON;
__at(0x000B) volatile __INTCONbits_t INTCONbits;

__at(0x000C) __sfr PORTA;
__at(0x000C) volatile __PORTAbits_t PORTAbits;

__at(0x000E) __sfr PORTC;
__at(0x000E) volatile __PORTCbits_t PORTCbits;

__at(0x0010) __sfr PIR1;
__at(0x0010) volatile __PIR1bits_t PIR1bits;

__at(0x0011) __sfr PIR2;
__at(0x0011) volatile __PIR2bits_t PIR2bits;

__at(0x0012) __sfr PIR3;
__at(0x0012) volatile __PIR3bits_t PIR3bits;

__at(0x0013) __sfr PIR4;
__at(0x0013) volatile __PIR4bits_t PIR4bits;

__at(0x0014) __sfr PIR5;
__at(0x0014) volatile __PIR5bits_t PIR5bits;

__at(0x0015) __sfr TMR0;

__at(0x0016) __sfr TMR1;

__at(0x0016) __sfr TMR1L;

__at(0x0017) __sfr TMR1H;

__at(0x0018) __sfr T1CON;
__at(0x0018) volatile __T1CONbits_t T1CONbits;

__at(0x0019) __sfr T1GCON;
__at(0x0019) volatile __T1GCONbits_t T1GCONbits;

__at(0x001A) __sfr T2TMR;

__at(0x001A) __sfr TMR2;

__at(0x001B) __sfr PR2;

__at(0x001B) __sfr T2PR;

__at(0x001C) __sfr T2CON;
__at(0x001C) volatile __T2CONbits_t T2CONbits;

__at(0x001D) __sfr T2HLT;
__at(0x001D) volatile __T2HLTbits_t T2HLTbits;

__at(0x001E) __sfr T2CLKCON;
__at(0x001E) volatile __T2CLKCONbits_t T2CLKCONbits;

__at(0x001F) __sfr T2RST;
__at(0x001F) volatile __T2RSTbits_t T2RSTbits;

__at(0x008C) __sfr TRISA;
__at(0x008C) volatile __TRISAbits_t TRISAbits;

__at(0x008E) __sfr TRISC;
__at(0x008E) volatile __TRISCbits_t TRISCbits;

__at(0x0090) __sfr PIE1;
__at(0x0090) volatile __PIE1bits_t PIE1bits;

__at(0x0091) __sfr PIE2;
__at(0x0091) volatile __PIE2bits_t PIE2bits;

__at(0x0092) __sfr PIE3;
__at(0x0092) volatile __PIE3bits_t PIE3bits;

__at(0x0093) __sfr PIE4;
__at(0x0093) volatile __PIE4bits_t PIE4bits;

__at(0x0094) __sfr PIE5;
__at(0x0094) volatile __PIE5bits_t PIE5bits;

__at(0x0095) __sfr OPTION_REG;
__at(0x0095) volatile __OPTION_REGbits_t OPTION_REGbits;

__at(0x0096) __sfr PCON;
__at(0x0096) volatile __PCONbits_t PCONbits;

__at(0x0098) __sfr OSCTUNE;
__at(0x0098) volatile __OSCTUNEbits_t OSCTUNEbits;

__at(0x0099) __sfr OSCCON;
__at(0x0099) volatile __OSCCONbits_t OSCCONbits;

__at(0x009A) __sfr OSCSTAT;
__at(0x009A) volatile __OSCSTATbits_t OSCSTATbits;

__at(0x009B) __sfr ADRES;

__at(0x009B) __sfr ADRESL;

__at(0x009C) __sfr ADRESH;

__at(0x009D) __sfr ADCON0;
__at(0x009D) volatile __ADCON0bits_t ADCON0bits;

__at(0x009E) __sfr ADCON1;
__at(0x009E) volatile __ADCON1bits_t ADCON1bits;

__at(0x009F) __sfr ADCON2;
__at(0x009F) volatile __ADCON2bits_t ADCON2bits;

__at(0x010C) __sfr LATA;
__at(0x010C) volatile __LATAbits_t LATAbits;

__at(0x010E) __sfr LATC;
__at(0x010E) volatile __LATCbits_t LATCbits;

__at(0x0111) __sfr CM1CON0;
__at(0x0111) volatile __CM1CON0bits_t CM1CON0bits;

__at(0x0112) __sfr CM1CON1;
__at(0x0112) volatile __CM1CON1bits_t CM1CON1bits;

__at(0x0113) __sfr CM2CON0;
__at(0x0113) volatile __CM2CON0bits_t CM2CON0bits;

__at(0x0114) __sfr CM2CON1;
__at(0x0114) volatile __CM2CON1bits_t CM2CON1bits;

__at(0x0115) __sfr CMOUT;
__at(0x0115) volatile __CMOUTbits_t CMOUTbits;

__at(0x0116) __sfr BORCON;
__at(0x0116) volatile __BORCONbits_t BORCONbits;

__at(0x0117) __sfr FVRCON;
__at(0x0117) volatile __FVRCONbits_t FVRCONbits;

__at(0x0118) __sfr DAC1CON0;
__at(0x0118) volatile __DAC1CON0bits_t DAC1CON0bits;

__at(0x0119) __sfr DAC1CON1;
__at(0x0119) volatile __DAC1CON1bits_t DAC1CON1bits;

__at(0x011C) __sfr ZCD1CON;
__at(0x011C) volatile __ZCD1CONbits_t ZCD1CONbits;

__at(0x018C) __sfr ANSELA;
__at(0x018C) volatile __ANSELAbits_t ANSELAbits;

__at(0x018E) __sfr ANSELC;
__at(0x018E) volatile __ANSELCbits_t ANSELCbits;

__at(0x0191) __sfr PMADR;

__at(0x0191) __sfr PMADRL;

__at(0x0192) __sfr PMADRH;

__at(0x0193) __sfr PMDAT;

__at(0x0193) __sfr PMDATL;

__at(0x0194) __sfr PMDATH;

__at(0x0195) __sfr PMCON1;
__at(0x0195) volatile __PMCON1bits_t PMCON1bits;

__at(0x0196) __sfr PMCON2;

__at(0x0197) __sfr VREGCON;
__at(0x0197) volatile __VREGCONbits_t VREGCONbits;

__at(0x0199) __sfr RC1REG;

__at(0x0199) __sfr RCREG;

__at(0x0199) __sfr RCREG1;

__at(0x019A) __sfr TX1REG;

__at(0x019A) __sfr TXREG;

__at(0x019A) __sfr TXREG1;

__at(0x019B) __sfr SP1BRG;

__at(0x019B) __sfr SP1BRGL;

__at(0x019B) __sfr SPBRG;

__at(0x019B) __sfr SPBRG1;

__at(0x019B) __sfr SPBRGL;

__at(0x019C) __sfr SP1BRGH;

__at(0x019C) __sfr SPBRGH;

__at(0x019C) __sfr SPBRGH1;

__at(0x019D) __sfr RC1STA;
__at(0x019D) volatile __RC1STAbits_t RC1STAbits;

__at(0x019D) __sfr RCSTA;
__at(0x019D) volatile __RCSTAbits_t RCSTAbits;

__at(0x019D) __sfr RCSTA1;
__at(0x019D) volatile __RCSTA1bits_t RCSTA1bits;

__at(0x019E) __sfr TX1STA;
__at(0x019E) volatile __TX1STAbits_t TX1STAbits;

__at(0x019E) __sfr TXSTA;
__at(0x019E) volatile __TXSTAbits_t TXSTAbits;

__at(0x019E) __sfr TXSTA1;
__at(0x019E) volatile __TXSTA1bits_t TXSTA1bits;

__at(0x019F) __sfr BAUD1CON;
__at(0x019F) volatile __BAUD1CONbits_t BAUD1CONbits;

__at(0x019F) __sfr BAUDCON;
__at(0x019F) volatile __BAUDCONbits_t BAUDCONbits;

__at(0x019F) __sfr BAUDCON1;
__at(0x019F) volatile __BAUDCON1bits_t BAUDCON1bits;

__at(0x019F) __sfr BAUDCTL;
__at(0x019F) volatile __BAUDCTLbits_t BAUDCTLbits;

__at(0x019F) __sfr BAUDCTL1;
__at(0x019F) volatile __BAUDCTL1bits_t BAUDCTL1bits;

__at(0x020C) __sfr WPUA;
__at(0x020C) volatile __WPUAbits_t WPUAbits;

__at(0x020E) __sfr WPUC;
__at(0x020E) volatile __WPUCbits_t WPUCbits;

__at(0x0211) __sfr SSP1BUF;
__at(0x0211) volatile __SSP1BUFbits_t SSP1BUFbits;

__at(0x0211) __sfr SSPBUF;
__at(0x0211) volatile __SSPBUFbits_t SSPBUFbits;

__at(0x0212) __sfr SSP1ADD;
__at(0x0212) volatile __SSP1ADDbits_t SSP1ADDbits;

__at(0x0212) __sfr SSPADD;
__at(0x0212) volatile __SSPADDbits_t SSPADDbits;

__at(0x0213) __sfr SSP1MSK;
__at(0x0213) volatile __SSP1MSKbits_t SSP1MSKbits;

__at(0x0213) __sfr SSPMSK;
__at(0x0213) volatile __SSPMSKbits_t SSPMSKbits;

__at(0x0214) __sfr SSP1STAT;
__at(0x0214) volatile __SSP1STATbits_t SSP1STATbits;

__at(0x0214) __sfr SSPSTAT;
__at(0x0214) volatile __SSPSTATbits_t SSPSTATbits;

__at(0x0215) __sfr SSP1CON;
__at(0x0215) volatile __SSP1CONbits_t SSP1CONbits;

__at(0x0215) __sfr SSP1CON1;
__at(0x0215) volatile __SSP1CON1bits_t SSP1CON1bits;

__at(0x0215) __sfr SSPCON;
__at(0x0215) volatile __SSPCONbits_t SSPCONbits;

__at(0x0215) __sfr SSPCON1;
__at(0x0215) volatile __SSPCON1bits_t SSPCON1bits;

__at(0x0216) __sfr SSP1CON2;
__at(0x0216) volatile __SSP1CON2bits_t SSP1CON2bits;

__at(0x0216) __sfr SSPCON2;
__at(0x0216) volatile __SSPCON2bits_t SSPCON2bits;

__at(0x0217) __sfr SSP1CON3;
__at(0x0217) volatile __SSP1CON3bits_t SSP1CON3bits;

__at(0x0217) __sfr SSPCON3;
__at(0x0217) volatile __SSPCON3bits_t SSPCON3bits;

__at(0x028C) __sfr ODCONA;
__at(0x028C) volatile __ODCONAbits_t ODCONAbits;

__at(0x028E) __sfr ODCONC;
__at(0x028E) volatile __ODCONCbits_t ODCONCbits;

__at(0x0291) __sfr CCPR1;

__at(0x0291) __sfr CCPR1L;

__at(0x0292) __sfr CCPR1H;

__at(0x0293) __sfr CCP1CON;
__at(0x0293) volatile __CCP1CONbits_t CCP1CONbits;

__at(0x0294) __sfr CCP1CAP;
__at(0x0294) volatile __CCP1CAPbits_t CCP1CAPbits;

__at(0x0298) __sfr CCPR2;

__at(0x0298) __sfr CCPR2L;

__at(0x0299) __sfr CCPR2H;

__at(0x029A) __sfr CCP2CON;
__at(0x029A) volatile __CCP2CONbits_t CCP2CONbits;

__at(0x029B) __sfr CCP2CAP;
__at(0x029B) volatile __CCP2CAPbits_t CCP2CAPbits;

__at(0x029E) __sfr CCPTMRS;
__at(0x029E) volatile __CCPTMRSbits_t CCPTMRSbits;

__at(0x030C) __sfr SLRCONA;
__at(0x030C) volatile __SLRCONAbits_t SLRCONAbits;

__at(0x030E) __sfr SLRCONC;
__at(0x030E) volatile __SLRCONCbits_t SLRCONCbits;

__at(0x038C) __sfr INLVLA;
__at(0x038C) volatile __INLVLAbits_t INLVLAbits;

__at(0x038E) __sfr INLVLC;
__at(0x038E) volatile __INLVLCbits_t INLVLCbits;

__at(0x0391) __sfr IOCAP;
__at(0x0391) volatile __IOCAPbits_t IOCAPbits;

__at(0x0392) __sfr IOCAN;
__at(0x0392) volatile __IOCANbits_t IOCANbits;

__at(0x0393) __sfr IOCAF;
__at(0x0393) volatile __IOCAFbits_t IOCAFbits;

__at(0x0397) __sfr IOCCP;
__at(0x0397) volatile __IOCCPbits_t IOCCPbits;

__at(0x0398) __sfr IOCCN;
__at(0x0398) volatile __IOCCNbits_t IOCCNbits;

__at(0x0399) __sfr IOCCF;
__at(0x0399) volatile __IOCCFbits_t IOCCFbits;

__at(0x040E) __sfr HIDRVC;
__at(0x040E) volatile __HIDRVCbits_t HIDRVCbits;

__at(0x0413) __sfr T4TMR;

__at(0x0413) __sfr TMR4;

__at(0x0414) __sfr PR4;

__at(0x0414) __sfr T4PR;

__at(0x0415) __sfr T4CON;
__at(0x0415) volatile __T4CONbits_t T4CONbits;

__at(0x0416) __sfr T4HLT;
__at(0x0416) volatile __T4HLTbits_t T4HLTbits;

__at(0x0417) __sfr T4CLKCON;
__at(0x0417) volatile __T4CLKCONbits_t T4CLKCONbits;

__at(0x0418) __sfr T4RST;
__at(0x0418) volatile __T4RSTbits_t T4RSTbits;

__at(0x041A) __sfr T6TMR;

__at(0x041A) __sfr TMR6;

__at(0x041B) __sfr PR6;

__at(0x041B) __sfr T6PR;

__at(0x041C) __sfr T6CON;
__at(0x041C) volatile __T6CONbits_t T6CONbits;

__at(0x041D) __sfr T6HLT;
__at(0x041D) volatile __T6HLTbits_t T6HLTbits;

__at(0x041E) __sfr T6CLKCON;
__at(0x041E) volatile __T6CLKCONbits_t T6CLKCONbits;

__at(0x041F) __sfr T6RST;
__at(0x041F) volatile __T6RSTbits_t T6RSTbits;

__at(0x0493) __sfr TMR3L;

__at(0x0494) __sfr TMR3H;

__at(0x0495) __sfr T3CON;
__at(0x0495) volatile __T3CONbits_t T3CONbits;

__at(0x0496) __sfr T3GCON;
__at(0x0496) volatile __T3GCONbits_t T3GCONbits;

__at(0x049A) __sfr TMR5L;

__at(0x049B) __sfr TMR5H;

__at(0x049C) __sfr T5CON;
__at(0x049C) volatile __T5CONbits_t T5CONbits;

__at(0x049D) __sfr T5GCON;
__at(0x049D) volatile __T5GCONbits_t T5GCONbits;

__at(0x058C) __sfr PID1SET;

__at(0x058C) __sfr PID1SETL;
__at(0x058C) volatile __PID1SETLbits_t PID1SETLbits;

__at(0x058D) __sfr PID1SETH;
__at(0x058D) volatile __PID1SETHbits_t PID1SETHbits;

__at(0x058E) __sfr PID1IN;

__at(0x058E) __sfr PID1INL;
__at(0x058E) volatile __PID1INLbits_t PID1INLbits;

__at(0x058F) __sfr PID1INH;
__at(0x058F) volatile __PID1INHbits_t PID1INHbits;

__at(0x0590) __sfr PID1K1;

__at(0x0590) __sfr PID1K1L;
__at(0x0590) volatile __PID1K1Lbits_t PID1K1Lbits;

__at(0x0591) __sfr PID1K1H;
__at(0x0591) volatile __PID1K1Hbits_t PID1K1Hbits;

__at(0x0592) __sfr PID1K2;

__at(0x0592) __sfr PID1K2L;
__at(0x0592) volatile __PID1K2Lbits_t PID1K2Lbits;

__at(0x0593) __sfr PID1K2H;
__at(0x0593) volatile __PID1K2Hbits_t PID1K2Hbits;

__at(0x0594) __sfr PID1K3;

__at(0x0594) __sfr PID1K3L;
__at(0x0594) volatile __PID1K3Lbits_t PID1K3Lbits;

__at(0x0595) __sfr PID1K3H;
__at(0x0595) volatile __PID1K3Hbits_t PID1K3Hbits;

__at(0x0596) __sfr PID1OUT;

__at(0x0596) __sfr PID1OUTLL;
__at(0x0596) volatile __PID1OUTLLbits_t PID1OUTLLbits;

__at(0x0597) __sfr PID1OUTLH;
__at(0x0597) volatile __PID1OUTLHbits_t PID1OUTLHbits;

__at(0x0598) __sfr PID1OUTHL;
__at(0x0598) volatile __PID1OUTHLbits_t PID1OUTHLbits;

__at(0x0599) __sfr PID1OUTHH;
__at(0x0599) volatile __PID1OUTHHbits_t PID1OUTHHbits;

__at(0x059A) __sfr PID1OUTU;
__at(0x059A) volatile __PID1OUTUbits_t PID1OUTUbits;

__at(0x059B) __sfr PID1Z1;

__at(0x059B) __sfr PID1Z1L;
__at(0x059B) volatile __PID1Z1Lbits_t PID1Z1Lbits;

__at(0x059C) __sfr PID1Z1H;
__at(0x059C) volatile __PID1Z1Hbits_t PID1Z1Hbits;

__at(0x059D) __sfr PID1Z1U;
__at(0x059D) volatile __PID1Z1Ubits_t PID1Z1Ubits;

__at(0x060C) __sfr PID1Z2;

__at(0x060C) __sfr PID1Z2L;
__at(0x060C) volatile __PID1Z2Lbits_t PID1Z2Lbits;

__at(0x060D) __sfr PID1Z2H;
__at(0x060D) volatile __PID1Z2Hbits_t PID1Z2Hbits;

__at(0x060E) __sfr PID1Z2U;
__at(0x060E) volatile __PID1Z2Ubits_t PID1Z2Ubits;

__at(0x060F) __sfr PID1ACC;

__at(0x060F) __sfr PID1ACCLL;
__at(0x060F) volatile __PID1ACCLLbits_t PID1ACCLLbits;

__at(0x0610) __sfr PID1ACCLH;
__at(0x0610) volatile __PID1ACCLHbits_t PID1ACCLHbits;

__at(0x0611) __sfr PID1ACCHL;
__at(0x0611) volatile __PID1ACCHLbits_t PID1ACCHLbits;

__at(0x0612) __sfr PID1ACCHH;
__at(0x0612) volatile __PID1ACCHHbits_t PID1ACCHHbits;

__at(0x0613) __sfr PID1ACCU;
__at(0x0613) volatile __PID1ACCUbits_t PID1ACCUbits;

__at(0x0614) __sfr PID1CON;
__at(0x0614) volatile __PID1CONbits_t PID1CONbits;

__at(0x0617) __sfr PWM3DCL;
__at(0x0617) volatile __PWM3DCLbits_t PWM3DCLbits;

__at(0x0618) __sfr PWM3DCH;
__at(0x0618) volatile __PWM3DCHbits_t PWM3DCHbits;

__at(0x0619) __sfr PWM3CON;
__at(0x0619) volatile __PWM3CONbits_t PWM3CONbits;

__at(0x061A) __sfr PWM4DCL;
__at(0x061A) volatile __PWM4DCLbits_t PWM4DCLbits;

__at(0x061B) __sfr PWM4DCH;
__at(0x061B) volatile __PWM4DCHbits_t PWM4DCHbits;

__at(0x061C) __sfr PWM4CON;
__at(0x061C) volatile __PWM4CONbits_t PWM4CONbits;

__at(0x0691) __sfr CWG1DBR;
__at(0x0691) volatile __CWG1DBRbits_t CWG1DBRbits;

__at(0x0692) __sfr CWG1DBF;
__at(0x0692) volatile __CWG1DBFbits_t CWG1DBFbits;

__at(0x0693) __sfr CWG1AS0;
__at(0x0693) volatile __CWG1AS0bits_t CWG1AS0bits;

__at(0x0694) __sfr CWG1AS1;
__at(0x0694) volatile __CWG1AS1bits_t CWG1AS1bits;

__at(0x0695) __sfr CWG1OCON0;
__at(0x0695) volatile __CWG1OCON0bits_t CWG1OCON0bits;

__at(0x0696) __sfr CWG1CON0;
__at(0x0696) volatile __CWG1CON0bits_t CWG1CON0bits;

__at(0x0697) __sfr CWG1CON1;
__at(0x0697) volatile __CWG1CON1bits_t CWG1CON1bits;

__at(0x0699) __sfr CWG1CLKCON;
__at(0x0699) volatile __CWG1CLKCONbits_t CWG1CLKCONbits;

__at(0x069A) __sfr CWG1ISM;
__at(0x069A) volatile __CWG1ISMbits_t CWG1ISMbits;

__at(0x0711) __sfr WDTCON0;
__at(0x0711) volatile __WDTCON0bits_t WDTCON0bits;

__at(0x0712) __sfr WDTCON1;
__at(0x0712) volatile __WDTCON1bits_t WDTCON1bits;

__at(0x0713) __sfr WDTPSL;
__at(0x0713) volatile __WDTPSLbits_t WDTPSLbits;

__at(0x0714) __sfr WDTPSH;
__at(0x0714) volatile __WDTPSHbits_t WDTPSHbits;

__at(0x0715) __sfr WDTTMR;
__at(0x0715) volatile __WDTTMRbits_t WDTTMRbits;

__at(0x0718) __sfr SCANLADR;

__at(0x0718) __sfr SCANLADRL;
__at(0x0718) volatile __SCANLADRLbits_t SCANLADRLbits;

__at(0x0719) __sfr SCANLADRH;
__at(0x0719) volatile __SCANLADRHbits_t SCANLADRHbits;

__at(0x071A) __sfr SCANHADR;

__at(0x071A) __sfr SCANHADRL;
__at(0x071A) volatile __SCANHADRLbits_t SCANHADRLbits;

__at(0x071B) __sfr SCANHADRH;
__at(0x071B) volatile __SCANHADRHbits_t SCANHADRHbits;

__at(0x071C) __sfr SCANCON0;
__at(0x071C) volatile __SCANCON0bits_t SCANCON0bits;

__at(0x071D) __sfr SCANTRIG;
__at(0x071D) volatile __SCANTRIGbits_t SCANTRIGbits;

__at(0x0791) __sfr CRCDAT;

__at(0x0791) __sfr CRCDATL;
__at(0x0791) volatile __CRCDATLbits_t CRCDATLbits;

__at(0x0792) __sfr CRCDATH;
__at(0x0792) volatile __CRCDATHbits_t CRCDATHbits;

__at(0x0793) __sfr CRCACC;

__at(0x0793) __sfr CRCACCL;
__at(0x0793) volatile __CRCACCLbits_t CRCACCLbits;

__at(0x0794) __sfr CRCACCH;
__at(0x0794) volatile __CRCACCHbits_t CRCACCHbits;

__at(0x0795) __sfr CRCSHIFT;

__at(0x0795) __sfr CRCSHIFTL;
__at(0x0795) volatile __CRCSHIFTLbits_t CRCSHIFTLbits;

__at(0x0796) __sfr CRCSHIFTH;
__at(0x0796) volatile __CRCSHIFTHbits_t CRCSHIFTHbits;

__at(0x0797) __sfr CRCXOR;

__at(0x0797) __sfr CRCXORL;
__at(0x0797) volatile __CRCXORLbits_t CRCXORLbits;

__at(0x0798) __sfr CRCXORH;
__at(0x0798) volatile __CRCXORHbits_t CRCXORHbits;

__at(0x0799) __sfr CRCCON0;
__at(0x0799) volatile __CRCCON0bits_t CRCCON0bits;

__at(0x079A) __sfr CRCCON1;
__at(0x079A) volatile __CRCCON1bits_t CRCCON1bits;

__at(0x080C) __sfr AT1RES;

__at(0x080C) __sfr AT1RESL;
__at(0x080C) volatile __AT1RESLbits_t AT1RESLbits;

__at(0x080D) __sfr AT1RESH;
__at(0x080D) volatile __AT1RESHbits_t AT1RESHbits;

__at(0x080E) __sfr AT1MISS;

__at(0x080E) __sfr AT1MISSL;
__at(0x080E) volatile __AT1MISSLbits_t AT1MISSLbits;

__at(0x080F) __sfr AT1MISSH;
__at(0x080F) volatile __AT1MISSHbits_t AT1MISSHbits;

__at(0x0810) __sfr AT1PER;

__at(0x0810) __sfr AT1PERL;
__at(0x0810) volatile __AT1PERLbits_t AT1PERLbits;

__at(0x0811) __sfr AT1PERH;
__at(0x0811) volatile __AT1PERHbits_t AT1PERHbits;

__at(0x0812) __sfr AT1PHS;

__at(0x0812) __sfr AT1PHSL;
__at(0x0812) volatile __AT1PHSLbits_t AT1PHSLbits;

__at(0x0813) __sfr AT1PHSH;
__at(0x0813) volatile __AT1PHSHbits_t AT1PHSHbits;

__at(0x0814) __sfr AT1CON0;
__at(0x0814) volatile __AT1CON0bits_t AT1CON0bits;

__at(0x0815) __sfr AT1CON1;
__at(0x0815) volatile __AT1CON1bits_t AT1CON1bits;

__at(0x0816) __sfr AT1IR0;
__at(0x0816) volatile __AT1IR0bits_t AT1IR0bits;

__at(0x0817) __sfr AT1IE0;
__at(0x0817) volatile __AT1IE0bits_t AT1IE0bits;

__at(0x0818) __sfr AT1IR1;
__at(0x0818) volatile __AT1IR1bits_t AT1IR1bits;

__at(0x0819) __sfr AT1IE1;
__at(0x0819) volatile __AT1IE1bits_t AT1IE1bits;

__at(0x081A) __sfr AT1STPT;

__at(0x081A) __sfr AT1STPTL;
__at(0x081A) volatile __AT1STPTLbits_t AT1STPTLbits;

__at(0x081B) __sfr AT1STPTH;
__at(0x081B) volatile __AT1STPTHbits_t AT1STPTHbits;

__at(0x081C) __sfr AT1ERR;

__at(0x081C) __sfr AT1ERRL;
__at(0x081C) volatile __AT1ERRLbits_t AT1ERRLbits;

__at(0x081D) __sfr AT1ERRH;
__at(0x081D) volatile __AT1ERRHbits_t AT1ERRHbits;

__at(0x088C) __sfr AT1CLK;
__at(0x088C) volatile __AT1CLKbits_t AT1CLKbits;

__at(0x088D) __sfr AT1SIG;
__at(0x088D) volatile __AT1SIGbits_t AT1SIGbits;

__at(0x088E) __sfr AT1CSEL1;
__at(0x088E) volatile __AT1CSEL1bits_t AT1CSEL1bits;

__at(0x088F) __sfr AT1CC1;

__at(0x088F) __sfr AT1CC1L;
__at(0x088F) volatile __AT1CC1Lbits_t AT1CC1Lbits;

__at(0x0890) __sfr AT1CC1H;
__at(0x0890) volatile __AT1CC1Hbits_t AT1CC1Hbits;

__at(0x0891) __sfr AT1CCON1;
__at(0x0891) volatile __AT1CCON1bits_t AT1CCON1bits;

__at(0x0892) __sfr AT1CSEL2;
__at(0x0892) volatile __AT1CSEL2bits_t AT1CSEL2bits;

__at(0x0893) __sfr AT1CC2;

__at(0x0893) __sfr AT1CC2L;
__at(0x0893) volatile __AT1CC2Lbits_t AT1CC2Lbits;

__at(0x0894) __sfr AT1CC2H;
__at(0x0894) volatile __AT1CC2Hbits_t AT1CC2Hbits;

__at(0x0895) __sfr AT1CCON2;
__at(0x0895) volatile __AT1CCON2bits_t AT1CCON2bits;

__at(0x0896) __sfr AT1CSEL3;
__at(0x0896) volatile __AT1CSEL3bits_t AT1CSEL3bits;

__at(0x0897) __sfr AT1CC3;

__at(0x0897) __sfr AT1CC3L;
__at(0x0897) volatile __AT1CC3Lbits_t AT1CC3Lbits;

__at(0x0898) __sfr AT1CC3H;
__at(0x0898) volatile __AT1CC3Hbits_t AT1CC3Hbits;

__at(0x0899) __sfr AT1CCON3;
__at(0x0899) volatile __AT1CCON3bits_t AT1CCON3bits;

__at(0x0D8C) __sfr SMT1TMR;

__at(0x0D8C) __sfr SMT1TMRL;
__at(0x0D8C) volatile __SMT1TMRLbits_t SMT1TMRLbits;

__at(0x0D8D) __sfr SMT1TMRH;
__at(0x0D8D) volatile __SMT1TMRHbits_t SMT1TMRHbits;

__at(0x0D8E) __sfr SMT1TMRU;
__at(0x0D8E) volatile __SMT1TMRUbits_t SMT1TMRUbits;

__at(0x0D8F) __sfr SMT1CPR;

__at(0x0D8F) __sfr SMT1CPRL;
__at(0x0D8F) volatile __SMT1CPRLbits_t SMT1CPRLbits;

__at(0x0D90) __sfr SMT1CPRH;
__at(0x0D90) volatile __SMT1CPRHbits_t SMT1CPRHbits;

__at(0x0D91) __sfr SMT1CPRU;
__at(0x0D91) volatile __SMT1CPRUbits_t SMT1CPRUbits;

__at(0x0D92) __sfr SMT1CPW;

__at(0x0D92) __sfr SMT1CPWL;
__at(0x0D92) volatile __SMT1CPWLbits_t SMT1CPWLbits;

__at(0x0D93) __sfr SMT1CPWH;
__at(0x0D93) volatile __SMT1CPWHbits_t SMT1CPWHbits;

__at(0x0D94) __sfr SMT1CPWU;
__at(0x0D94) volatile __SMT1CPWUbits_t SMT1CPWUbits;

__at(0x0D95) __sfr SMT1PR;

__at(0x0D95) __sfr SMT1PRL;
__at(0x0D95) volatile __SMT1PRLbits_t SMT1PRLbits;

__at(0x0D96) __sfr SMT1PRH;
__at(0x0D96) volatile __SMT1PRHbits_t SMT1PRHbits;

__at(0x0D97) __sfr SMT1PRU;
__at(0x0D97) volatile __SMT1PRUbits_t SMT1PRUbits;

__at(0x0D98) __sfr SMT1CON0;
__at(0x0D98) volatile __SMT1CON0bits_t SMT1CON0bits;

__at(0x0D99) __sfr SMT1CON1;
__at(0x0D99) volatile __SMT1CON1bits_t SMT1CON1bits;

__at(0x0D9A) __sfr SMT1STAT;
__at(0x0D9A) volatile __SMT1STATbits_t SMT1STATbits;

__at(0x0D9B) __sfr SMT1CLK;
__at(0x0D9B) volatile __SMT1CLKbits_t SMT1CLKbits;

__at(0x0D9C) __sfr SMT1SIG;
__at(0x0D9C) volatile __SMT1SIGbits_t SMT1SIGbits;

__at(0x0D9D) __sfr SMT1WIN;
__at(0x0D9D) volatile __SMT1WINbits_t SMT1WINbits;

__at(0x0D9E) __sfr SMT2TMR;

__at(0x0D9E) __sfr SMT2TMRL;
__at(0x0D9E) volatile __SMT2TMRLbits_t SMT2TMRLbits;

__at(0x0D9F) __sfr SMT2TMRH;
__at(0x0D9F) volatile __SMT2TMRHbits_t SMT2TMRHbits;

__at(0x0DA0) __sfr SMT2TMRU;
__at(0x0DA0) volatile __SMT2TMRUbits_t SMT2TMRUbits;

__at(0x0DA1) __sfr SMT2CPR;

__at(0x0DA1) __sfr SMT2CPRL;
__at(0x0DA1) volatile __SMT2CPRLbits_t SMT2CPRLbits;

__at(0x0DA2) __sfr SMT2CPRH;
__at(0x0DA2) volatile __SMT2CPRHbits_t SMT2CPRHbits;

__at(0x0DA3) __sfr SMT2CPRU;
__at(0x0DA3) volatile __SMT2CPRUbits_t SMT2CPRUbits;

__at(0x0DA4) __sfr SMT2CPW;

__at(0x0DA4) __sfr SMT2CPWL;
__at(0x0DA4) volatile __SMT2CPWLbits_t SMT2CPWLbits;

__at(0x0DA5) __sfr SMT2CPWH;
__at(0x0DA5) volatile __SMT2CPWHbits_t SMT2CPWHbits;

__at(0x0DA6) __sfr SMT2CPWU;
__at(0x0DA6) volatile __SMT2CPWUbits_t SMT2CPWUbits;

__at(0x0DA7) __sfr SMT2PR;

__at(0x0DA7) __sfr SMT2PRL;
__at(0x0DA7) volatile __SMT2PRLbits_t SMT2PRLbits;

__at(0x0DA8) __sfr SMT2PRH;
__at(0x0DA8) volatile __SMT2PRHbits_t SMT2PRHbits;

__at(0x0DA9) __sfr SMT2PRU;
__at(0x0DA9) volatile __SMT2PRUbits_t SMT2PRUbits;

__at(0x0DAA) __sfr SMT2CON0;
__at(0x0DAA) volatile __SMT2CON0bits_t SMT2CON0bits;

__at(0x0DAB) __sfr SMT2CON1;
__at(0x0DAB) volatile __SMT2CON1bits_t SMT2CON1bits;

__at(0x0DAC) __sfr SMT2STAT;
__at(0x0DAC) volatile __SMT2STATbits_t SMT2STATbits;

__at(0x0DAD) __sfr SMT2CLK;
__at(0x0DAD) volatile __SMT2CLKbits_t SMT2CLKbits;

__at(0x0DAE) __sfr SMT2SIG;
__at(0x0DAE) volatile __SMT2SIGbits_t SMT2SIGbits;

__at(0x0DAF) __sfr SMT2WIN;
__at(0x0DAF) volatile __SMT2WINbits_t SMT2WINbits;

__at(0x0E0F) __sfr PPSLOCK;
__at(0x0E0F) volatile __PPSLOCKbits_t PPSLOCKbits;

__at(0x0E10) __sfr INTPPS;
__at(0x0E10) volatile __INTPPSbits_t INTPPSbits;

__at(0x0E11) __sfr T0CKIPPS;
__at(0x0E11) volatile __T0CKIPPSbits_t T0CKIPPSbits;

__at(0x0E12) __sfr T1CKIPPS;
__at(0x0E12) volatile __T1CKIPPSbits_t T1CKIPPSbits;

__at(0x0E13) __sfr T1GPPS;
__at(0x0E13) volatile __T1GPPSbits_t T1GPPSbits;

__at(0x0E14) __sfr CCP1PPS;
__at(0x0E14) volatile __CCP1PPSbits_t CCP1PPSbits;

__at(0x0E15) __sfr CCP2PPS;
__at(0x0E15) volatile __CCP2PPSbits_t CCP2PPSbits;

__at(0x0E16) __sfr ATINPPS;
__at(0x0E16) volatile __ATINPPSbits_t ATINPPSbits;

__at(0x0E17) __sfr CWGINPPS;
__at(0x0E17) volatile __CWGINPPSbits_t CWGINPPSbits;

__at(0x0E18) __sfr T2PPS;
__at(0x0E18) volatile __T2PPSbits_t T2PPSbits;

__at(0x0E19) __sfr T3CKIPPS;
__at(0x0E19) volatile __T3CKIPPSbits_t T3CKIPPSbits;

__at(0x0E1A) __sfr T3GPPS;
__at(0x0E1A) volatile __T3GPPSbits_t T3GPPSbits;

__at(0x0E1B) __sfr T4PPS;
__at(0x0E1B) volatile __T4PPSbits_t T4PPSbits;

__at(0x0E1C) __sfr T5CKIPPS;
__at(0x0E1C) volatile __T5CKIPPSbits_t T5CKIPPSbits;

__at(0x0E1D) __sfr T5GPPS;
__at(0x0E1D) volatile __T5GPPSbits_t T5GPPSbits;

__at(0x0E1E) __sfr T6PPS;
__at(0x0E1E) volatile __T6PPSbits_t T6PPSbits;

__at(0x0E1F) __sfr ATCC1PPS;
__at(0x0E1F) volatile __ATCC1PPSbits_t ATCC1PPSbits;

__at(0x0E20) __sfr SSPCLKPPS;
__at(0x0E20) volatile __SSPCLKPPSbits_t SSPCLKPPSbits;

__at(0x0E21) __sfr SSPDATPPS;
__at(0x0E21) volatile __SSPDATPPSbits_t SSPDATPPSbits;

__at(0x0E22) __sfr SSPSSPPS;
__at(0x0E22) volatile __SSPSSPPSbits_t SSPSSPPSbits;

__at(0x0E23) __sfr ATCC2PPS;
__at(0x0E23) volatile __ATCC2PPSbits_t ATCC2PPSbits;

__at(0x0E24) __sfr RXPPS;
__at(0x0E24) volatile __RXPPSbits_t RXPPSbits;

__at(0x0E25) __sfr CKPPS;
__at(0x0E25) volatile __CKPPSbits_t CKPPSbits;

__at(0x0E26) __sfr SMT1SIGPPS;
__at(0x0E26) volatile __SMT1SIGPPSbits_t SMT1SIGPPSbits;

__at(0x0E27) __sfr SMT1WINPPS;
__at(0x0E27) volatile __SMT1WINPPSbits_t SMT1WINPPSbits;

__at(0x0E28) __sfr CLCIN0PPS;
__at(0x0E28) volatile __CLCIN0PPSbits_t CLCIN0PPSbits;

__at(0x0E29) __sfr CLCIN1PPS;
__at(0x0E29) volatile __CLCIN1PPSbits_t CLCIN1PPSbits;

__at(0x0E2A) __sfr CLCIN2PPS;
__at(0x0E2A) volatile __CLCIN2PPSbits_t CLCIN2PPSbits;

__at(0x0E2B) __sfr CLCIN3PPS;
__at(0x0E2B) volatile __CLCIN3PPSbits_t CLCIN3PPSbits;

__at(0x0E2C) __sfr SMT2SIGPPS;
__at(0x0E2C) volatile __SMT2SIGPPSbits_t SMT2SIGPPSbits;

__at(0x0E2D) __sfr SMT2WINPPS;
__at(0x0E2D) volatile __SMT2WINPPSbits_t SMT2WINPPSbits;

__at(0x0E2E) __sfr ATCC3PPS;
__at(0x0E2E) volatile __ATCC3PPSbits_t ATCC3PPSbits;

__at(0x0E90) __sfr RA0PPS;
__at(0x0E90) volatile __RA0PPSbits_t RA0PPSbits;

__at(0x0E91) __sfr RA1PPS;
__at(0x0E91) volatile __RA1PPSbits_t RA1PPSbits;

__at(0x0E92) __sfr RA2PPS;
__at(0x0E92) volatile __RA2PPSbits_t RA2PPSbits;

__at(0x0E94) __sfr RA4PPS;
__at(0x0E94) volatile __RA4PPSbits_t RA4PPSbits;

__at(0x0E95) __sfr RA5PPS;
__at(0x0E95) volatile __RA5PPSbits_t RA5PPSbits;

__at(0x0EA0) __sfr RC0PPS;
__at(0x0EA0) volatile __RC0PPSbits_t RC0PPSbits;

__at(0x0EA1) __sfr RC1PPS;
__at(0x0EA1) volatile __RC1PPSbits_t RC1PPSbits;

__at(0x0EA2) __sfr RC2PPS;
__at(0x0EA2) volatile __RC2PPSbits_t RC2PPSbits;

__at(0x0EA3) __sfr RC3PPS;
__at(0x0EA3) volatile __RC3PPSbits_t RC3PPSbits;

__at(0x0EA4) __sfr RC4PPS;
__at(0x0EA4) volatile __RC4PPSbits_t RC4PPSbits;

__at(0x0EA5) __sfr RC5PPS;
__at(0x0EA5) volatile __RC5PPSbits_t RC5PPSbits;

__at(0x0F0F) __sfr CLCDATA;
__at(0x0F0F) volatile __CLCDATAbits_t CLCDATAbits;

__at(0x0F10) __sfr CLC1CON;
__at(0x0F10) volatile __CLC1CONbits_t CLC1CONbits;

__at(0x0F11) __sfr CLC1POL;
__at(0x0F11) volatile __CLC1POLbits_t CLC1POLbits;

__at(0x0F12) __sfr CLC1SEL0;
__at(0x0F12) volatile __CLC1SEL0bits_t CLC1SEL0bits;

__at(0x0F13) __sfr CLC1SEL1;
__at(0x0F13) volatile __CLC1SEL1bits_t CLC1SEL1bits;

__at(0x0F14) __sfr CLC1SEL2;
__at(0x0F14) volatile __CLC1SEL2bits_t CLC1SEL2bits;

__at(0x0F15) __sfr CLC1SEL3;
__at(0x0F15) volatile __CLC1SEL3bits_t CLC1SEL3bits;

__at(0x0F16) __sfr CLC1GLS0;
__at(0x0F16) volatile __CLC1GLS0bits_t CLC1GLS0bits;

__at(0x0F17) __sfr CLC1GLS1;
__at(0x0F17) volatile __CLC1GLS1bits_t CLC1GLS1bits;

__at(0x0F18) __sfr CLC1GLS2;
__at(0x0F18) volatile __CLC1GLS2bits_t CLC1GLS2bits;

__at(0x0F19) __sfr CLC1GLS3;
__at(0x0F19) volatile __CLC1GLS3bits_t CLC1GLS3bits;

__at(0x0F1A) __sfr CLC2CON;
__at(0x0F1A) volatile __CLC2CONbits_t CLC2CONbits;

__at(0x0F1B) __sfr CLC2POL;
__at(0x0F1B) volatile __CLC2POLbits_t CLC2POLbits;

__at(0x0F1C) __sfr CLC2SEL0;
__at(0x0F1C) volatile __CLC2SEL0bits_t CLC2SEL0bits;

__at(0x0F1D) __sfr CLC2SEL1;
__at(0x0F1D) volatile __CLC2SEL1bits_t CLC2SEL1bits;

__at(0x0F1E) __sfr CLC2SEL2;
__at(0x0F1E) volatile __CLC2SEL2bits_t CLC2SEL2bits;

__at(0x0F1F) __sfr CLC2SEL3;
__at(0x0F1F) volatile __CLC2SEL3bits_t CLC2SEL3bits;

__at(0x0F20) __sfr CLC2GLS0;
__at(0x0F20) volatile __CLC2GLS0bits_t CLC2GLS0bits;

__at(0x0F21) __sfr CLC2GLS1;
__at(0x0F21) volatile __CLC2GLS1bits_t CLC2GLS1bits;

__at(0x0F22) __sfr CLC2GLS2;
__at(0x0F22) volatile __CLC2GLS2bits_t CLC2GLS2bits;

__at(0x0F23) __sfr CLC2GLS3;
__at(0x0F23) volatile __CLC2GLS3bits_t CLC2GLS3bits;

__at(0x0F24) __sfr CLC3CON;
__at(0x0F24) volatile __CLC3CONbits_t CLC3CONbits;

__at(0x0F25) __sfr CLC3POL;
__at(0x0F25) volatile __CLC3POLbits_t CLC3POLbits;

__at(0x0F26) __sfr CLC3SEL0;
__at(0x0F26) volatile __CLC3SEL0bits_t CLC3SEL0bits;

__at(0x0F27) __sfr CLC3SEL1;
__at(0x0F27) volatile __CLC3SEL1bits_t CLC3SEL1bits;

__at(0x0F28) __sfr CLC3SEL2;
__at(0x0F28) volatile __CLC3SEL2bits_t CLC3SEL2bits;

__at(0x0F29) __sfr CLC3SEL3;
__at(0x0F29) volatile __CLC3SEL3bits_t CLC3SEL3bits;

__at(0x0F2A) __sfr CLC3GLS0;
__at(0x0F2A) volatile __CLC3GLS0bits_t CLC3GLS0bits;

__at(0x0F2B) __sfr CLC3GLS1;
__at(0x0F2B) volatile __CLC3GLS1bits_t CLC3GLS1bits;

__at(0x0F2C) __sfr CLC3GLS2;
__at(0x0F2C) volatile __CLC3GLS2bits_t CLC3GLS2bits;

__at(0x0F2D) __sfr CLC3GLS3;
__at(0x0F2D) volatile __CLC3GLS3bits_t CLC3GLS3bits;

__at(0x0F2E) __sfr CLC4CON;
__at(0x0F2E) volatile __CLC4CONbits_t CLC4CONbits;

__at(0x0F2F) __sfr CLC4POL;
__at(0x0F2F) volatile __CLC4POLbits_t CLC4POLbits;

__at(0x0F30) __sfr CLC4SEL0;
__at(0x0F30) volatile __CLC4SEL0bits_t CLC4SEL0bits;

__at(0x0F31) __sfr CLC4SEL1;
__at(0x0F31) volatile __CLC4SEL1bits_t CLC4SEL1bits;

__at(0x0F32) __sfr CLC4SEL2;
__at(0x0F32) volatile __CLC4SEL2bits_t CLC4SEL2bits;

__at(0x0F33) __sfr CLC4SEL3;
__at(0x0F33) volatile __CLC4SEL3bits_t CLC4SEL3bits;

__at(0x0F34) __sfr CLC4GLS0;
__at(0x0F34) volatile __CLC4GLS0bits_t CLC4GLS0bits;

__at(0x0F35) __sfr CLC4GLS1;
__at(0x0F35) volatile __CLC4GLS1bits_t CLC4GLS1bits;

__at(0x0F36) __sfr CLC4GLS2;
__at(0x0F36) volatile __CLC4GLS2bits_t CLC4GLS2bits;

__at(0x0F37) __sfr CLC4GLS3;
__at(0x0F37) volatile __CLC4GLS3bits_t CLC4GLS3bits;

__at(0x0FE4) __sfr STATUS_SHAD;
__at(0x0FE4) volatile __STATUS_SHADbits_t STATUS_SHADbits;

__at(0x0FE5) __sfr WREG_SHAD;

__at(0x0FE6) __sfr BSR_SHAD;

__at(0x0FE7) __sfr PCLATH_SHAD;

__at(0x0FE8) __sfr FSR0L_SHAD;

__at(0x0FE9) __sfr FSR0H_SHAD;

__at(0x0FEA) __sfr FSR1L_SHAD;

__at(0x0FEB) __sfr FSR1H_SHAD;

__at(0x0FED) __sfr STKPTR;

__at(0x0FEE) __sfr TOSL;

__at(0x0FEF) __sfr TOSH;