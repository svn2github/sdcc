#include "types.h"
#include <stdlib.h>
#include <assert.h>
#include <stdio.h>
#include <string.h>

typedef struct {
    uint16 addr;
    const char *szName;
} SYM_ENTRY;

struct _MAP {
    SYM_ENTRY *syms;
    int numSyms;
    int maxSyms;
};

static MAP *_grow(MAP *pMap)
{
    assert(pMap);

    if (pMap->numSyms == pMap->maxSyms) {
        pMap->maxSyms = (pMap->maxSyms + 1)*2;
        pMap->syms = (SYM_ENTRY*) realloc(pMap->syms, pMap->maxSyms*sizeof(*pMap->syms));
        assert(pMap->syms);
    }
    else {
        /* Already big enough. */
    }
    return pMap;
}

static char *_chomp(char *sz)
{
    do {
        char *p = strrchr(sz, '\n');
        if (p != NULL) {
            *p = '\0';
            continue;
        }
        p = strrchr(sz, '\r');
        if (p != NULL) {
            *p = '\0';
            continue;
        }
        break;
    } while (1);

    return sz;
}

MAP *map_load(const char *fname)
{
    FILE *fp = fopen(fname, "r");
    char line[MAX_LINE];

    if (fp == NULL) {
        return NULL;
    }
    else {
        MAP *pmap = (MAP*) calloc(1, sizeof(*pmap));

        while (fgets(line, sizeof(line), fp) != NULL) {
            int drop, addr;
            char *start;

            /* Drop comment lines. */
            if (line[0] == ';') {
                continue;
            }
            /* Read in the segment and address. */
            if (sscanf(line, "%X:%X", &drop, &addr) != 2) {
                continue;
            }

            start = strrchr(line, ' ');
            if (start == NULL) {
                /* Invalid? */
                continue;
            }

            _chomp(line);
            /* Move on past the space. */
            start++;

            /* Drop any internal names, like the segment start and length
               symbols. */
            if (!strncmp(start, "s__", 3)) {
                continue;
            }

            pmap = _grow(pmap);
            pmap->syms[pmap->numSyms].addr = addr;
            pmap->syms[pmap->numSyms].szName = strdup(start);

            pmap->numSyms++;
        }
        fclose(fp);
        return pmap;
    }
}

const char *map_find(MAP *self, uint16 addr)
{
    if (self != NULL) {
        int i;
        for (i = 0; i < self->numSyms; i++) {
            if (self->syms[i].addr == addr) {
                return self->syms[i].szName;
            }
        }
    }
    return NULL;
}

const char *map_lookup(MAP *self, uint16 addr, char *pInto)
{
    if (self != NULL) {
        int i;
        for (i = 0; i < self->numSyms; i++) {
            if (self->syms[i].addr == addr) {
                return self->syms[i].szName;
            }
        }
    }
    sprintf(pInto, "%04X", addr);

    return pInto;
}
