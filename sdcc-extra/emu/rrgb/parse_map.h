#ifndef __PARSE_MAP_H
#define __PARSE_MAP_H

#define UWORD unsigned int
#define SECT_AREA 1
#define SECT_AREA_GLOBALS 1

typedef struct sglobal mglobal;
typedef struct sglobal *pmglobal;

struct sglobal {
	char	name[50];
	UWORD	addr;
	pmglobal next;
	pmglobal sorted_next;
};

typedef struct sarea marea;
typedef struct sarea *pmarea;

struct sarea {
	char	name[50];
	UWORD	base;
	UWORD	size;
	pmglobal globals;
	pmarea next;
};

int parse_map( char *file_name, pmarea *first_area );
int global_compare( const void *glob1, const void *glob2 );
int sort_globals( pmglobal *first_global, pmarea first );

#endif
