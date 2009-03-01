typedef unsigned int uint32;
typedef unsigned char uint8;
typedef signed char int8;
typedef unsigned short uint16;

typedef struct _MAP MAP;

MAP *map_load(const char *fname);
const char *map_lookup(MAP *self, uint16 addr, char *pInto);
const char *map_find(MAP *self, uint16 addr);

enum {
    MAX_LINE = 128
};


