/** Very simple Z80 CPU emulator.
 */
#include "cpu/z80.h"
#include "cpu/z80_def.h"

#include <stdio.h>
#include <stdarg.h>

/** Names for the system traps.  Set A to one of these and call RST 08
    with parameteres in HL.  Any return value will also be in HL.  
*/
enum {
    /** Exit the emulator (normal exit). */
    RST_08_EXIT_EMU,
    /** Print the character in L to the screen. */
    RST_08_PUTCHAR
};

/** System trap implementation. */
OPDEF(rst_08, 0xC7+8)
{
    switch (RA) {
    case RST_08_EXIT_EMU:
        exit(0);
        break;
    case RST_08_PUTCHAR:
        putchar(RL);
        fflush(stdout);
        break;
    default:
        printf("Unsupported RST 08 code %02Xh\n", RA);
    }
    ENDOP();
}

/** Display an error message and exit the program.  Like throw.  Rely
    on system support for closing any open files, freeing memory etc.
*/
static void fatal(const char *format, ...)
{
    va_list ap;
    va_start(ap, format);

    vprintf(format, ap);
    printf("\n");

    va_end(ap);

    exit(-1);
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

int main(int argc, char **argv)
{
    if (argc != 2) {
        fatal("Usage: %s romimage.bin", argv[0]);
    }

    // Setup the emulation.
    z80_init();

    // Load the given rom image file.
    loadImage(argv[1]);

    // Reset the emu
    z80_reset();

    do {
        // And run for a random amount of time.
        z80_step(100);
    } while (1);

    return 0;
}
