#ifndef __DISGB_H
#define __DISGB_H

#include "parse_map.h"

typedef unsigned char UBYTE;

extern pmarea areas;
extern pmglobal sorted_globals;

int disass( char *buffer, UBYTE *base, int addr );
int format_label( char *buffer, unsigned int addr );
int parse_label( char *buffer );

#endif
