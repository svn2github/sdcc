/** Very simple Z80 CPU emulator.
 */
#include "cpu/z80.h"
#include "cpu/z80_def.h"

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <time.h>
#include <assert.h>

#include "types.h"

int disass_z80(FILE *f, uint32 adr);

enum {
    FALSE,
    TRUE
};

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

enum {
    MEMORY_SIZE = 65536
};

enum {
    PROFILE_ENTER_OFFSET = 3
};

#define PROFILE_FILE_NAME	"profile.out"

static struct {
    /** If set trace execution by dumping the code as it executes. */
    int trace;
    /** If set the return registers will be dumped when a ret is hit. */
    int dumpRet;
    /** If set dumps the register contents at each instruction. */
    int traceRegs;
    /** If set, does an outline depth trace. */
    int traceOutlineDepth;
    /** Loaded map file if any. */
    MAP *pmap;
    /** If set indents the debug output based on the call depth. */
    int traceWithDepth;
    /** Current call depth from the start of the program. */
    int callDepth;
    /** Total t-states since start. */
    unsigned long tStates;
    struct {
        int enable;
        unsigned long *ticks;
        unsigned long *calls;
        long startTStates;
        int callStack[1024];
        int callDepth;
        int inLeaf;
    } profile;
} _G;

/** Display an error message and exit the program.  Like throw.  Rely
    on system support for closing any open files, freeing memory etc.
*/
static void fatal(const char *format, ...)
{
    va_list ap;
    va_start(ap, format);

    vfprintf(stderr, format, ap);
    fprintf(stderr, "\n");

    va_end(ap);

    exit(-2);
}

void exitEmu(void)
{
    if (_G.profile.enable) {
        int i;
        FILE *fp = fopen(PROFILE_FILE_NAME, "w");

        if (fp == NULL) {
            fatal("Failure while opening " PROFILE_FILE_NAME);
        }

        fprintf(fp, "; Function total-ticks total-calls ticks-per-call total-percent\n");

        for (i = 0; i < MEMORY_SIZE; i++) {
            if (_G.profile.ticks[i] != 0) {
                char buffer[128];
                fprintf(fp, "%s %lu %lu %lu %.2f\n", map_lookup(_G.pmap, (uint16)i, buffer), 
                        _G.profile.ticks[i],
                        _G.profile.calls[i],
                        _G.profile.ticks[i]/_G.profile.calls[i],
                        100.0 * _G.profile.ticks[i] / _G.tStates
                       );
            }
        }
        fprintf(fp, "; %lu t-states\n", _G.tStates);
        fclose(fp);

        printf("%lu t-states\n", _G.tStates);
    }

    exit(0);
}

static void printEnterExitLog(int pc, int isEnter)
{
    static const char spaces[] = "                                                        ";
    char buffer[MAX_LINE];

    if (isEnter) {
	fprintf(stderr, "%s%s %s\n", 
		spaces + sizeof(spaces) - _G.callDepth*2, 
		isEnter ? "Entered " : "Leaving",
		map_lookup(_G.pmap, pc, buffer));
    }
    else {
	fprintf(stderr, "%sLeaving\n",
		spaces + sizeof(spaces) - _G.callDepth*2
		);
    }
}

static void handleEnter(void)
{
    if (_G.profile.enable) {
        /* Started a new function. */
        /* Record the time spent in the last function. */
        _G.profile.ticks[_G.profile.callStack[_G.profile.callDepth]] += _G.tStates - _G.profile.startTStates;
        /* Re-start the timer */
        _G.profile.startTStates = _G.tStates;
        /* Push this fun onto the call stack */
        _G.profile.callStack[++_G.profile.callDepth] = PC - PROFILE_ENTER_OFFSET;
        /* Increase the call count. */
        _G.profile.calls[_G.profile.callStack[_G.profile.callDepth]]++;
        assert(_G.profile.callDepth < 1023);
        /* And continue */
    }
    if (_G.traceOutlineDepth) {
	int pc = PC - PROFILE_ENTER_OFFSET;
	printEnterExitLog(pc, 1);
    }
    _G.callDepth++;
}

static void handleExit(void)
{
    if (_G.profile.enable) {
        /* Record the time spent in this function. */
        _G.profile.ticks[_G.profile.callStack[_G.profile.callDepth]] += _G.tStates - _G.profile.startTStates;
        /* Re-start the timer */
        _G.profile.startTStates = _G.tStates;
        /* Pop this fun off the call stack */
        _G.profile.callDepth--;
        assert(_G.profile.callDepth >= 0);
    }
    _G.profile.inLeaf = FALSE;
    _G.callDepth--;
    assert(_G.callDepth >= 0);

    if (_G.traceOutlineDepth) {
	printEnterExitLog(PC, 0);
    }
}

void returnHook(void)
{
    if (_G.profile.inLeaf) {
        handleExit();
        _G.profile.inLeaf = FALSE;
    }
}

/** System trap implementation. */
OPDEF(rst_08, 0xC7+8)
{
    switch (RA) {
    case RST_08_EXIT_EMU:
        exitEmu();
        break;
    case RST_08_PUTCHAR:
        putchar(RL);
        fflush(stdout);
        if (RL == '\n' || RL == '\r') {
            fflush(stdout);
        }
        break;
    case RST_08_GET_CLOCK:
        HL = _G.tStates / (CPU_SPEED/CPU_CLOCKS_PER_SECOND);
        break;
    case RST_08_PROFILE_ENTER:
        if (_G.profile.inLeaf) {
            printf("Asserting.  Last %04X, this %04X\n", _G.profile.callStack[_G.profile.callDepth], PC);
        }
        assert(!_G.profile.inLeaf);
        handleEnter();
        break;
    case RST_08_PROFILE_EXIT:
        handleExit();
        break;
    case RST_08_PROFILE_ENTER_LEAF:
        assert(!_G.profile.inLeaf);
        handleEnter();
        _G.profile.inLeaf = TRUE;
        break;
    default:
        printf("Unsupported RST 08 code %02Xh\n", RA);
    }
    ENDOP();
}

unsigned char mon_read_byte(unsigned int addr)
{
    return z80_proc.mem[addr];
}

void debug_z80(void)
{
    if (_G.trace) {
        char buffer[MAX_LINE];
        fprintf(stderr, "%s:\t", map_lookup(_G.pmap, PC, buffer));
        disass_z80(stderr, PC);

        if (_G.traceRegs) {
            fprintf(stderr, "\tAF: %04X BC: %04X DE: %04X HL: %04X SP: %04X IX: %04X\n", AF, BC, DE, HL, SP, IX);
        }
        else {
            fprintf(stderr, "\n");
        }
    }
    else {
        // Tracing is off, do nothing.
    }
    if (_G.dumpRet && mon_read_byte(PC) == 0xC9) {
        fprintf(stderr, "--- Return: DE:HL = %04X:%04X\n", DE, HL);
    }
    else {
        // Dumping is off, do nothing.
    }
}

void profile_z80(int addr, int ticks)
{
    _G.tStates += ticks;
}

/** Load the given rom image into memory. */
static void loadImage(const char *fname)
{
    int got;
    FILE *fp = fopen(fname, "rb");

    if (!fp) {
        fatal("Couldn't open the rom image %s for reading.", fp);
    }

    got = fread(z80_proc.mem, 1, 65536, fp);
    if (got < 0) {
        fatal("Error while reading the rom image.");
    }

    fclose(fp);
}

static void usage(void)
{
    fatal("Usage: rrz80 [--trace] [--outlinedepthtrace] [--tracewithdepth] [--traceregs] [--dumpret] [--maxruntime=xx] [--mapfile=mapfilename] romimage.bin");
}

static int startsWith(const char *sz, const char *szStart)
{
    return !strncmp(sz, szStart, strlen(szStart));
}

static char *getStrVal(const char *sz)
{
    char *idx = strchr(sz, '=');
    assert(idx != NULL);

    return idx+1;
}

static int getIntVal(const char *sz)
{
    return atoi(getStrVal(sz));
}

int main(int argc, char **argv)
{
    time_t runUntil = 0;
    int i;

    const char *fname = NULL;

    for (i = 1; i < argc; i++) {
        if (argv[i][0] == '-') {
            if (startsWith(argv[i], "--maxruntime=")) {
                runUntil = time(NULL) + getIntVal(argv[i]);
            }
            else if (!strcmp(argv[i], "--trace")) {
                _G.trace = 1;
            }
            else if (!strcmp(argv[i], "--profile")) {
                _G.profile.enable = 1;
                _G.profile.ticks = (long unsigned int*) calloc(MEMORY_SIZE, sizeof(*_G.profile.ticks));
                _G.profile.calls = (long unsigned int*) calloc(MEMORY_SIZE, sizeof(*_G.profile.calls));
                if (_G.profile.ticks == NULL || _G.profile.calls == NULL) {
                    fatal("Out of memory while allocating profile array");
                }
            }
            else if (!strcmp(argv[i], "--traceregs")) {
                _G.traceRegs = 1;
            }
	    else if (!strcmp(argv[i], "--outlinedepthtrace")) {
		_G.traceOutlineDepth = 1;
	    }
            else if (!strcmp(argv[i], "--dumpret")) {
                _G.dumpRet = 1;
            }
            else if (!strcmp(argv[i], "--tracewithdepth")) {
                _G.traceWithDepth = 1;
            }
            else if (startsWith(argv[i], "--mapfile=")) {
                _G.pmap = map_load(getStrVal(argv[i]));
                if (_G.pmap == NULL) {
                    fatal("Couldn't open the map file %s.", getStrVal(argv[i]));
                }
            }
            else {
                usage();
            }
        }
        else {
            fname = argv[i];
        }
    }

    if (fname == NULL) {
        usage();
    }

    // Setup the emulation.
    z80_init();

    // Load the given rom image file.
    loadImage(fname);

    // Reset the emu
    z80_reset();

    do {
        // And run for a random amount of time.
        z80_step(1000);
    } while (runUntil == 0 || time(NULL) < runUntil);

    // Can only get here if the execution doesn't finish in time
    fprintf(stderr, "%s: timeout in running %s\n", argv[0], fname);

    return -1;
}
