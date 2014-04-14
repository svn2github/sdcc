/* rrgb, a rough and ready game boy emulator
 * Copyright (C) 1994 Ian Collier. rrgb changes (c) 1998 Michael Hope
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
#include <string.h>
#include <stdlib.h>
#include <signal.h>
#include <sys/time.h>
#if !defined(__sun__) && !defined(__APPLE__)
#include <getopt.h>
#endif
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <unistd.h>
#include "csock.h"
#include "z80.h"
#include "disgb.h"
#include "debugger.h"

#define ALLOW_WRITE 1

#ifdef SEG
unsigned char *segments[NUM_SEGS];
#endif
unsigned char mem[65536];
unsigned long tstates=0;
char bank_file_name[50];
int last_bank;
int tsocket;
int flags;

int loadImage(char *imageName, int flags);

/** Names for the system traps.  Set A to one of these and call RST 08
    with parameteres in HL.  Any return value will also be in HL.  
*/
enum {
    /** Exit the emulator (normal exit). */
    RST_08_EXIT_EMU,
    /** Print the character in L to the screen. */
    RST_08_PUTCHAR,
    /** Returns the run time in 1/100s. */
    RST_08_GET_CLOCK,
    RST_08_PROFILE_ENTER,
    RST_08_PROFILE_EXIT,
    RST_08_PROFILE_ENTER_LEAF
};

enum {
    CPU_SPEED = 4000000,
    CPU_CLOCKS_PER_SECOND = 100
};

void usage(void)
{
        printf("rrgb: Rough 'n Ready processor only Gameboy emulator.\n"
               "\tM.Hope " __DATE__ "\n"
               "Useage:\n"
               "\trrgb [-i] [-t] [-p] [-m] [-d] [-s name.bin] image.gb\n"
               "\t\t-p - Profile code.\n"
               "\t\t-m - Load map file.\n"
               "\t\t-d - Enter debugger before running.\n"
               "\t\t-s - Use name.bin as a segment file.\n"
               "\t\t-t - Open port 6808 for input.\n"
               "\t\t-i - Enable 100Hz timer interrupts.\n"
               "\t\t-k - Run for at most 20s.\n"
               );
}

void exitEmu(void)
{
    exit(0);
}

void handleRST08(struct sregs *pregs)
{
    switch (*pregs->a) {
    case RST_08_EXIT_EMU:
        exitEmu();
        break;
    case RST_08_PUTCHAR:
        putchar(*pregs->l);
        fflush(stdout);
        if (*pregs->l == '\n' || *pregs->l == '\r') {
            fflush(stdout);
        }
        break;
    case RST_08_GET_CLOCK: {
        unsigned ticks = tstates / (CPU_SPEED/CPU_CLOCKS_PER_SECOND);
        *pregs->e = (unsigned char)ticks;
        *pregs->d = (unsigned char)(ticks >> 8);
        break;
    }
    case RST_08_PROFILE_ENTER:
    case RST_08_PROFILE_EXIT:
    case RST_08_PROFILE_ENTER_LEAF:
        break;
    default:
        printf("Unsupported RST 08 code %02Xh\n", *pregs->a);
    }
}

int main(int argc,char **argv)
{
        int i, c;
        struct sockaddr_in sock;
        socklen_t sock_len;
        int hsocket = 0;

        flags=0;

        while ((c=getopt(argc, argv, "kpms:dti"))!=-1) {
                switch (c) {
                        case 'p': {
                                flags|=DPROFILE;
                                break;
                        }
                        case 'm': {
                                flags|=DMAP;
                                break;
                        }
                        case 's': {
                                strcpy(bank_file_name, optarg);
                                break;
                        }
                        case 'd': {
                                flags|=DSTARTDEBUG;
                                break;
                        }
                        case 't': {
                                flags|=DSOCKETS;
                                break;
                        }
                        case 'i': {
                                flags|=DTIMERINT;
                                break;
                        }
                        case 'k': {
                                flags|=DLIMITEDRUN;
                                break;
                        }
                        default: {
                                usage();
                                return -1;
                                break;
                        }
                }
        }

#ifdef SEG
        for (i=0; i< NUM_SEGS; i++) {
                segments[i] = &mem[i*SEG_SIZE];
        }
#endif
        if (optind<argc) {
                loadImage(argv[optind], flags);
        }
        else {
                printf("%s:Error: No image file specified.\n",argv[0]);
                return -2;
        }
        if (flags&DSOCKETS) {
                /* Open up the socket connection before proceeding */
                printf("Opening socket 6808...");
                fflush(stdout);

                hsocket = socket_init(6808);
                if (hsocket<0) {
                        printf("Failed.\n");
                        return -2;
                }
                else {
                        printf("Done.\n");
                        printf("Waiting for connection...");
                        fflush(stdout);

                        sock_len=sizeof(struct sockaddr_in);
                        tsocket = accept( hsocket, (struct sockaddr *)&sock, &sock_len );
                        if (tsocket==-1) {
                                printf("Failed.\n");
                                return -1;
                        }
                        else {
                                printf("Done.\n");
                        }
                }
        }

        mainloop(flags);

        if (flags&DPROFILE)
                profile();
        if (flags&DSOCKETS) {
                close(tsocket);
                close(hsocket);
        }
        printf("\nrrgb:  Total tstates: %lu.\n", tstates );

        return 0;
}


int loadImage(char *imageName, int flags)
{
        FILE *in;
        char *dot;
        char map_name[100];

        if((in=fopen(imageName,"rb"))!=NULL) {
                size_t got = fread( mem, 1, 32768, in );
                if (ferror(in)) {
                        perror("Error while reading the rom image");
                        return -1;
                }
                fclose(in);

                if (flags&DMAP) {
                        /* Try to find the map file */
                        areas = NULL;
                        sorted_globals = NULL;

                        if ((dot=strrchr( imageName, '.'))!=NULL) {
                                *dot = '\0';
                                strcpy( map_name, imageName );
                                strcat( map_name, ".map");
                                if (!parse_map( map_name, &areas )) {
                                        sort_globals( &sorted_globals, areas );
                                }
                                *dot = '.';
                        }
                        if (sorted_globals==NULL) {
                                printf("Warning:  no map file loaded.\n");
                        }
                }
                return 0;
        }
        else {
                printf("Couldn't load image %s.\n", imageName);
                return -1;
        }
}

/* Print out the floating point number stored in HLDE */
/* Format: H = Sign|Exponent, LDE = Mantissa */

void printGBfloat(unsigned fhl, unsigned fde)
{
        double a;

        /* Get mantissa */
        a = (65536.0 * (double)(fhl&0x0ff))+(double)fde;

        /* Multiply by 2^exponent */
        /* Seems to be normalised or something */
        a*=pow(2.0,(double)((fhl>>8)&~0x080)-88.0);

        /* Negative? */
        if (fhl & 0x08000)
                a = -a;
        printf("%f", a);
}

/* Switch in bank /bank to segment /segment */
void switchBank( int segment, unsigned bank )
{
        FILE *binFP;

        if (last_bank==bank)
                return;

#ifdef ALLOW_WRITE
        if (last_bank!=-1) {
                binFP = fopen( bank_file_name, "r+b" );
                if (binFP) {
                        /* Commit the last block first */
                        if (fseek( binFP, last_bank*SEG_SIZE, SEEK_SET)==0) {
                                if (fwrite(segments[segment], 1, SEG_SIZE, binFP )<SEG_SIZE) {
                                        printf("\nrrgb:  Failed write of bank %u.\n", last_bank );
                                }
                                else
                                        printf("\nrrgb: commited block %u.\n", last_bank );
                        }
                        fclose(binFP);
                }
                else {
                        printf("\nrrgb:  Failed write of bank %u.\n", last_bank );
                }
        }
#endif

        binFP = fopen( bank_file_name, "rb" );
        if (binFP) {
                if (fseek( binFP, bank*SEG_SIZE, SEEK_SET)==0) {
                        if (fread( segments[segment], 1, SEG_SIZE, binFP )<SEG_SIZE) {
                                printf("\nrrgb:  Incomplete read in bank %u.\n", bank );
                        }
                        last_bank = bank;
                                
/*                      printf("%02X %02X %02X %02X\n", segments[segment][0], segments[segment][1], segments[segment][2], segments[segment][3] );*/
                }
                else {
                        printf("\nrrgb:  Unable to seek to bank %u.\n", bank );
                }
                fclose( binFP );
        }
        else 
                printf("\nrrgb:  Warning:  No block file open.\n");
}

/* Handle a RST 38 (system call) */
int handle_sys(int scall, int parameter) 
{
        char buffer[2];
        switch (scall) {
                case 0: {
                        /* Read in from telnet */
                        if (flags&DSOCKETS) {
                                return socket_get(tsocket);
                        }
                        return 0;
                        break;
                }
                case 1: {
                        /* Write to telnet */
                        if (flags&DSOCKETS) {
                                buffer[0]=(parameter&0x0ff);
                                return socket_write( tsocket, buffer, 1);
                        }
                        return -1;
                }
                case 2: {
                        /* Return !0 if data is available */
                        if (flags&DSOCKETS) {
                                return socket_poll( tsocket );
                        }
                        return -1;
                }
        }
        return 0;
}
