<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
  <meta content="text/html; charset=UTF-8" http-equiv="content-type" />
  <title>SDCC Previous News and Changes</title>
  <link rel="stylesheet" href="styles/style.css" type="text/css" />
  <link rel="shortcut icon" type="image/x-icon" href="/images/sdcc.ico" />
</head>
<body link="teal" vlink="#483d8b">
<div align="left">
<h1>SDCC - Small Device C Compiler</h1>
<table bgcolor="white" border="0" cellpadding="2" cellspacing="1" width="100%">
  <tbody>
    <tr>
      <td valign="top" width="15%"><?php echo(file_get_contents('./left_menu.inc'));?>
      </td>
      <td width="85%">

      <h2>Previous NEWS</h2>

            <p><i><b>June 24th, 2015: Small Device C Compiler 3.5.0 released.</b></i></p>
            <p>A new release of SDCC, the portable optimizing compiler for 8051, DS390, Z80, Z180, Rabbit 2000,
              HC08, STM8 and PIC microprocessors is now available
              (<a href="http://sdcc.sourceforge.net" target="_new">http://sdcc.sourceforge.net</a>).
              Sources, documentation and binaries compiled for x86 Linux, x86 and x64 MS Windows and
              x86 and PPC Mac OS X are available. </p>
            <p>SDCC 3.5.0 Feature List:</p>
            <ul>
              <li>--disable-non-free configure option</li>
              <li>Changed default language dialect from --std-sdcc89 to --std-sdcc99</li>
              <li>Reorganized and updated manual</li>
              <li>Reduced memory consumption (most noticeable for high --max-allocs-per-node)</li>
              <li>Faster compilation for stm8 (most noticeable for high --max-allocs-per-node)</li>
              <li>atoll() function for conversion of strings to long long</li>
              <li>__z88dk_fastcall and __z88dk_callee calling conventions for more efficient function calls and better compability with z88dk</li>
              <li>--lospre-unsafe-read renamed to --allow-unsafe-read</li>
            </ul>
            <p>Numerous feature requests and bug fixes are included as well.</p>
            <p>You can download the release from:<br />
              <a href="https://sourceforge.net/projects/sdcc/files/" target="_new">https://sourceforge.net/projects/sdcc/files/</a></p>

            <p><i><b>June 20th, 2015: SDCC 3.5.0 RC2 released.</b></i></p>
            <p>SDCC 3.5.0 Release Candidate 2 source, doc and binary packages for x86 Linux,
              32 and 64 bit Windows and universal Mac OS X are available in corresponding folders at:
              <a href="http://sourceforge.net/projects/sdcc/files/">
              http://sourceforge.net/projects/sdcc/files/</a>.</p>

            <p><i><b>June 9th, 2015: SDCC 3.5.0 RC1 released.</b></i></p>
            <p>SDCC 3.5.0 Release Candidate 1 source, doc and binary packages for x86 Linux,
              32 and 64 bit Windows and universal Mac OS X are available in corresponding folders at:
              <a href="http://sourceforge.net/projects/sdcc/files/">
              http://sourceforge.net/projects/sdcc/files/</a>.</p>

      <p><i><b>April 11th, 2014: Small Device C Compiler 3.4.0 released.</b></i></p>
      <p>A new release of SDCC, the portable optimizing compiler for 8051, DS390, Z80, Z180, Rabbit 2000,
        HC08, STM8 and PIC microprocessors is now available
        (<a href="http://sdcc.sourceforge.net" target="_new">http://sdcc.sourceforge.net</a>).
        Sources, documentation and binaries compiled for x86 Linux, x86 and x64 MS Windows and
        x86 and PPC Mac OS X are available. </p>
      <p>SDCC 3.4.0 Feature List:</p>
      <ul>
        <li>New TLCS90 (Toshiba Z80 clone) target support</li>
        <li>New STMicroelectronics STM8 target support</li>
        <li>Support for named address spaces in ROM</li>
        <li>Detects supported devices by gputils when building SDCC</li>
      </ul>
      <p>Numerous feature requests and bug fixes are included as well.</p>
      <p>You can download the release from:<br />
        <a href="https://sourceforge.net/projects/sdcc/files/" target="_new">https://sourceforge.net/projects/sdcc/files/</a></p>

      <p><i><b>April 5th, 2014: SDCC 3.4.0 RC3 released.</b></i></p>
      <p>SDCC 3.4.0 Release Candidate 3 source, doc and binary packages for x86 Linux,
        32 bit Windows, 64 bit Windows and universal Mac OS X are available in corresponding folders at:
        <a href="http://sourceforge.net/projects/sdcc/files/">
        http://sourceforge.net/projects/sdcc/files/</a>.</p>

      <p><i><b>March 27th, 2014: SDCC 3.4.0 RC2 released.</b></i></p>
      <p>SDCC 3.4.0 Release Candidate 2 source, doc and binary packages for x86 Linux,
        32 bit Windows, 64 bit Windows and universal Mac OS X are available in corresponding folders at:
        <a href="http://sourceforge.net/projects/sdcc/files/">
        http://sourceforge.net/projects/sdcc/files/</a>.</p>

      <p><i><b>March 16th, 2014: SDCC 3.4.0 RC1 released.</b></i></p>
      <p>SDCC 3.4.0 Release Candidate 1 source, doc and binary packages for x86 Linux,
        32 bit Windows and universal Mac OS X are available in corresponding folders at:
        <a href="http://sourceforge.net/projects/sdcc/files/">
        http://sourceforge.net/projects/sdcc/files/</a>.</p>

      <p><i><b>May 20th, 2013: Small Device C Compiler 3.3.0 released.</b></i></p>
      <p>A new release of SDCC, the portable optimizing compiler for 8051, DS390, Z80, Z180, Rabbit 2000, HC08 and PIC microprocessors
        is now available (<a href="http://sdcc.sourceforge.net" target="_new">http://sdcc.sourceforge.net</a>). Sources, documentation
        and binaries compiled for x86 Linux, x86 and x64 MS Windows and x86 and PPC Mac OS X are available. </p>
      <p>SDCC 3.3.0 Feature List:</p>
      <ul>
        <li>Many small improvements in code generation for the z80-related ports - merged smallopts branch</li>
        <li>lospre (currently enabled for z80-related and hc08-related ports only) - merged lospre branch</li>
        <li>More efficient initialization of globals in z80, z180, r2k and r3ka ports.</li>
        <li>Inclusion of tests from the gcc test suite into the sdcc regression test suite led to many bugs being found and fixed.</li>
        <li>Split sdas390 from sdas8051</li>
        <li>Merged big parts of ASxxxx v5 into sdas</li>
        <li>New pic devices (synchronization with MPLABX 1.60). (Except for very old MCU-s.)</li>
        <li>New script which disassembles those hex files, in which MCS51 code there is. (mcs51-disasm.pl)</li>
        <li>Added the PIC16F1788 and PIC16F1789 devices.</li>
        <li>C11 _Alignof operator.</li>
        <li>C11 _Alignas alignment specifier.</li>
        <li>C11 _Static_Assert static assertion.</li>
      </ul>
      <p>Numerous feature requests and bug fixes are included as well.</p>
      <p>You can download the release from:<br />
        <a href="https://sourceforge.net/projects/sdcc/files/" target="_new">https://sourceforge.net/projects/sdcc/files/</a></p>

      <p><i><b>May 12th, 2013: SDCC 3.3.0 RC3 released.</b></i></p>
      <p>SDCC 3.3.0 Release Candidate 3 source, doc and binary packages for x86 Linux,
        32 bit Windows, 64 bit Windows and universal Mac OS X are available in corresponding folders at:
        <a href="http://sourceforge.net/projects/sdcc/files/">
        http://sourceforge.net/projects/sdcc/files/</a>.</p>

      <p><i><b>May 11th, 2013: SDCC 3.3.0 RC2 released.</b></i></p>
      <p>SDCC 3.3.0 Release Candidate 2 source, doc and binary packages for x86 Linux,
        32 bit Windows, 64 bit Windows and universal Mac OS X are available in corresponding folders at:
        <a href="http://sourceforge.net/projects/sdcc/files/">
        http://sourceforge.net/projects/sdcc/files/</a>.</p>

      <p><i><b>May 5th, 2013: SDCC 3.3.0 RC1 released.</b></i></p>
      <p>SDCC 3.3.0 Release Candidate 1 source, doc and binary packages for x86 Linux,
        32 bit Windows and universal Mac OS X are available in corresponding folders at:
        <a href="http://sourceforge.net/projects/sdcc/files/">
        http://sourceforge.net/projects/sdcc/files/</a>.</p>

      <p><i><b>July 9th, 2012: Small Device C Compiler 3.2.0 released.</b></i></p>
      <p>A new release of SDCC, the portable optimizing compiler for 8051, DS390, Z80, Z180, Rabbit 2000, HC08 and PIC microprocessors
        is now available (<a href="http://sdcc.sourceforge.net" target="_new">http://sdcc.sourceforge.net</a>). Sources, documentation
        and binaries compiled for x86 Linux, x86 MS Windows and PPC Mac OS X are available. </p>
      <p>SDCC 3.2.0 Feature List:</p>
      <ul>
        <li>Named address spaces with optimal placement of bank selection calls.</li>
        <li>_Noreturn.</li>
        <li>--std-c11 command line option for ISO C11.</li>
        <li>ucsim support for the LR35902 (gameboy CPU).</li>
        <li>The gbz80 port is alive again, there were many bug fixes and the generated code is much better now.</li>
        <li>Pic 14 enhanced core libraries are included in sdcc builds by default</li>
        <li>Added pic 14 enhanced core devices: 16f1503, 16f1508, 16f1509, 16f1516, 16f1517, 16f1518, 16f1519, 16f1526, 16f1527, 16f1946,
          16f1947</li>
        <li>PIC14/PIC16: Implemented __critical; PIC14 __critical function cannot have arguments for now, though</li>
        <li>inclusion of some tests from the gcc test suite into the sdcc regression test suite led to many bugs being found and fixed.</li>
        <li>Many macros with previously non-standard-compliant names have been renamed (SDCC_REVISION to __SDCC_REVISION, etc).</li>
        <li>setjmp() / longjmp() for the z180 and r2k ports.</li>
        <li>Added sdar archive managing utility. sdar and sdranlib are derived from GNU binutils package</li>
        <li>Added support for pic 14 core devices: 16f720, 16f721, 16f882, 16f883, 16f884, 16f747, 16f946</li>
        <li>sdcpp synchronized with GNU cpp 4.6.3</li>
        <li>Added support for pic 18f1230/18f1330 device family</li>
        <li>Implemented #pragma config for pic16 target</li>
        <li>sdcc now works on Debian GNU/Hurd.</li>
        <li>New register allocator for the hc08 port, resulting in better code being generated.</li>
        <li>New s08 port.</li>
        <li>New r3ka port.</li>
        <li>Many small improvements in the z80, hc08 and r2k code generation, reducing code size.</li>
        <li>Shift, multiplication, division and returning of long long are now supported (modulo for long long is still missing, integer
          literals of type long long are broken).
      </ul>
      <p>Numerous feature requests and bug fixes are included as well.</p>
      <p>You can download the release from:<br />
        <a href="https://sourceforge.net/projects/sdcc/files/" target="_new">https://sourceforge.net/projects/sdcc/files/</a></p>

      <p><i><b>July 6th, 2012: SDCC 3.2.0 RC4 released.</b></i></p>
      <p>SDCC 3.2.0 Release Candidate 4 source, doc and binary packages for x86 Linux,
        32 bit Windows and universal Mac OS X are available in corresponding folders at:
        <a href="http://sourceforge.net/projects/sdcc/files/">
        http://sourceforge.net/projects/sdcc/files/</a>.</p>

      <p><i><b>June 29th, 2012: SDCC 3.2.0 RC3 released.</b></i></p>
      <p>SDCC 3.2.0 Release Candidate 3 source, doc and binary packages for x86 Linux,
        32 bit Windows and universal Mac OS X are available in corresponding folders at:
        <a href="http://sourceforge.net/projects/sdcc/files/">
        http://sourceforge.net/projects/sdcc/files/</a>.</p>

      <p><i><b>June 24th, 2012: SDCC 3.2.0 RC2 released.</b></i></p>
      <p>SDCC 3.2.0 Release Candidate 2 source, doc and binary packages for x86 Linux,
        32 bit Windows and universal Mac OS X are available in corresponding folders at:
        <a href="http://sourceforge.net/projects/sdcc/files/">
        http://sourceforge.net/projects/sdcc/files/</a>.</p>

      <p><i><b>June 16th, 2012: SDCC 3.2.0 RC1 released.</b></i></p>
      <p>SDCC 3.2.0 Release Candidate 1 source, doc and binary packages for x86 Linux,
        32 bit Windows and universal Mac OS X are available in corresponding folders at:
        <a href="http://sourceforge.net/projects/sdcc/files/">
        http://sourceforge.net/projects/sdcc/files/</a>.</p>

      <p><i><b>November 27th, 2011: Small Device C Compiler 3.1.0 released.</b></i></p>
      <p>A new release of SDCC, the portable optimizing compiler for 8051, DS390, Z80,
        HC08, and PIC microprocessors is now available (<a href="http://sdcc.sourceforge.net"
        target="_new">http://sdcc.sourceforge.net</a>). Sources, documentation and binaries
        compiled for x86 Linux, x86 MS Windows and universal Mac OS X are available.</p>
      <p>SDCC 3.1.0 Feature List:</p>
      <ul>
        <li>include/pic, non-free/include/pic, lib/pic, non-free/lib/pic renamed to */pic14</li>
        <li>implemented --fomit-frame-pointer for mcs51</li>
        <li>support for use of sdcc in z88dk (--reserve-regs-iy and --no-optsdcc-in-asm options; smallc calling convention)</li>
        <li>new register allocator in the z80 and gbz80 ports (optimal when using --opt-code-size and a sufficiently high value for
          --max-allocs-per-node for the z80 port)</li>
        <li>C99 designated initializers</li>
        <li>added strxfrm() and strcoll() functions; strerror() is the only string handling function still missing</li>
        <li>added support for pic18f2xk22/pic18f4xk22 family (requires gputils > 0.14.0 and --enable-new-pics configure flag)</li>
        <li>added support for enhanced core pic14 devices (requires gputils > 0.14.0 and --enable-new-pics configure flag)</li>
        <li>setjmp() / longjmp() for the z80 port</li>
        <li>_Bool / bool for the hc08, pic16 and pic14 ports</li>
        <li>sdcpp synchronized with GNU cpp 4.6.1</li>
        <li>z180 port</li>
        <li>very basic (no integer constants, multiplication, division, shifts or use as return value) support for data types
          long long, unsigned long long, int_fast64_t, int_least64_t, int64_t, uint_fast64_t, uint_least64_t, uint64_t in the
          z80, z180, r2k and gbz80 ports</li>
        <li>r2k port for the Rabbit 2000 and Rabbit 3000</li>
      </ul>
      <p>Numerous feature requests and bug fixes are included as well.</p>
      <p>You can download the release from:<br />
        <a href="http://sourceforge.net/projects/sdcc/files/" target="_new">http://sourceforge.net/projects/sdcc/files/</a></p>

      <p></p>
      <hr width="60%" />
      <p></p>

      <p><i><b>November 22nd, 2011: SDCC 3.1.0 RC3 released.</b></i></p>
      <p>SDCC 3.1.0 Release Candidate 3 source, doc and binary packages for x86 Linux,
        32 bit Windows and universal Mac OS X are available at:
        <a href="http://sourceforge.net/projects/sdcc/files/snapshot_builds/sdcc-3.1.0-rc3/">
          http://sourceforge.net/projects/sdcc/files/snapshot_builds/sdcc-3.1.0-rc3</a>.</p>

      <p></p>
      <hr width="60%" />
      <p></p>

      <p><i><b>November 18th, 2011: SDCC 3.1.0 RC2 released.</b></i></p>
      <p>SDCC 3.1.0 Release Candidate 2 source, doc and binary packages for x86 Linux,
       32 bit Windows and universal Mac OS X are available at:
        <a href="http://sourceforge.net/projects/sdcc/files/snapshot_builds/sdcc-3.1.0-rc2/">
          http://sourceforge.net/projects/sdcc/files/snapshot_builds/sdcc-3.1.0-rc2</a>.</p>

      <p></p>
      <hr width="60%" />
      <p></p>

      <p><i><b>November 6th, 2011: SDCC 3.1.0 RC1 released.</b></i></p>
      <p>SDCC 3.1.0 Release Candidate 1 source, doc and binary packages for x86 Linux,
       32 bit Windows and universal Mac OS X are available at:
       <a href="http://sourceforge.net/projects/sdcc/files/snapshot_builds/sdcc-3.1.0-rc1/">
         http://sourceforge.net/projects/sdcc/files/snapshot_builds/sdcc-3.1.0-rc1</a>.</p>

      <p></p>
      <hr width="60%" />
      <p></p>

      <p><i><b>November 1st, 2010: Small Device C Compiler 3.0.0 released.</b></i></p>
      <p>A new release of SDCC, the portable optimizing compiler for 8051, DS390, Z80,
        HC08, and PIC microprocessors is now available (<a href="http://sdcc.sourceforge.net" target="_new">http://sdcc.sourceforge.net</a>).
        Sources, documentation and binaries compiled for x86 Linux, x86 MS Windows and universal Mac OS X are available.</p>
      <p>SDCC 3.0.0 Feature List:</p>
      <ul>
        <li>sdcpp synchronized with GNU cpp 4.5.0</li>
        <li>changed z80 and gb targets object file extension to .rel</li>
        <li>special sdcc keywords which are not preceded by a double underscore
          are deprecated in sdcc version 3.0.0 and higher. See section ANSI-Compliance in sdccman</li>
        <li>xa51 and avr targets are disabled by default in sdcc version 3.0.0 and higher</li>
        <li>introduced new memory model huge for mcs51 to use bankswitching for all functions</li>
        <li>removed generation of GameBoy binary image file format, rrgb map file
          format and no$gmb sym file format from sdld linker. Utility makebin
          generates GameBoy binary image file format, utility as2gbmap utility
          converts sdas map file to rrgb map and no$gmb sym file formas.</li>
        <li>implemented __builtin_offsetof</li>
        <li>asxxxx / aslink renamed to sdas / sdld and synchronized with ASXXXX V2.0</li>
        <li>majority of sdcc run time library released under GPL+LE license
          (see http://sourceforge.net/apps/trac/sdcc/wiki/Files%20and%20Licenses)</li>
        <li>introduced --use-non-free command line option</li>
        <li>non free (non GPL compatible) header and library files moved to non-free directory</li>
        <li>deprecated --no-pack-iram command line option</li>
      </ul>
      <p>Numerous feature requests and bug fixes are included as well.</p>
      <p>You can download the release from:<br />
        <a href="http://sourceforge.net/projects/sdcc/files/" target="_new">http://sourceforge.net/projects/sdcc/files/</a></p>

      <p></p>
      <hr width="60%" />
      <p></p>

      <p><i><b>October 22nd, 2010: SDCC 3.0.0 RC2 released.</b></i></p>
      <p>SDCC 3.0.0 Release Candidate 2 source, doc and binary packages for x86 Linux,
        32 bit Windows and universal Mac OS X are available at:
        <a href="http://sourceforge.net/projects/sdcc/files/snapshot_builds/sdcc-3.0.0-rc2/">
          http://sourceforge.net/projects/sdcc/files/snapshot_builds/sdcc-3.0.0-rc2</a>.</p>

      <p></p>
      <hr width="60%" />
      <p></p>

      <p><i><b>October 10th, 2010: SDCC 3.0.0 RC1 released.</b></i></p>
      <p>SDCC 3.0.0 Release Candidate 1 source, doc and binary packages for x86 Linux,
        32 bit Windows and universal Mac OS X are available at:
        <a href="http://sourceforge.net/projects/sdcc/files/snapshot_builds/sdcc-3.0.0-rc1/">
          http://sourceforge.net/projects/sdcc/files/snapshot_builds/sdcc-3.0.0-rc1</a>.</p>

      <p></p>
      <hr width="60%" />
      <p></p>

      <p><i><b>March 22th, 2009: Small Device C Compiler 2.9.0 released.</b></i></p>
      <p>A new release of SDCC, the portable optimizing compiler for 8051, DS390, Z80,
        HC08, and PIC microprocessors is now available (<a href="http://sdcc.sourceforge.net" target="_new">http://sdcc.sourceforge.net</a>).
        Sources, documentation and binaries compiled for x86 Linux, x86 MS Windows and
        universal Mac OS X are available.</p>
      <p>SDCC 2.9.0 Feature List:</p>
      <ul>
        <li>sdcpp synchronized with GNU cpp 4.3.3</li>
        <li>Integer constants written in binary (prefix 0b or 0B, followed by a sequence
          of 0 and 1digits) are now supported as a SDCC extension.</li>
        <li>pic16 *printf() library functions return int</li>
        <li>disabled support of undocumented and not standard compliant 'b' binary 
          format specifier ("%b", "%hb" and "%lb") in pic16 *printf() and printf_tiny() library functions</li>
        <li>fixed initialization of unnamed bitfields members of objects of structure and union type</li>
        <li>many optimizations to reduce code size and increase speed in the Z80 backend</li>
        <li>added support for ar format libraries to adcc asxxxx</li>
        <li>libraries, included in sdcc packages, are in ar format</li>
        <li>sdcc asxxxx license changed to GPLv3</li>
        <li>added support for many PIC16 devices</li>
      </ul>
      <p>Numerous feature requests and bug fixes are included as well.</p>
      <p>You can download the release from:<br />
        <a href="http://sourceforge.net/project/showfiles.php?group_id=599" target="_new">http://sourceforge.net/project/showfiles.php?group_id=599</a></p>

      <p></p>
      <hr width="60%" />
      <p></p>

      <p><i><b>March 15th, 2009: SDCC 2.9.0 RC2 released.</b></i></p>
      <p>SDCC 2.9.0 Release Candidate 2 source, doc and binary packages for x86 Linux,
        32 bit Windows and universal Mac OS X are available at:
        <a href="http://sdcc.sourceforge.net/snap.php">http://sdcc.sourceforge.net/snap.php</a>.</p>

      <p></p>
      <hr width="60%" />
      <p></p>

      <p><i><b>March 1st, 2009: SDCC 2.9.0 RC1 released.</b></i></p>
      <p>SDCC 2.9.0 Release Candidate 1 source, doc and binary packages for x86 Linux,
        32 bit Windows and universal Mac OS X are available at:
        <a href="http://sdcc.sourceforge.net/snap.php">http://sdcc.sourceforge.net/snap.php</a>.</p>

      <p></p>
      <hr width="60%" />
      <p></p>

      <p><i><b>March 30th, 2008: Small Device C Compiler 2.8.0 released.</b></i></p>
      <p>A new release of SDCC, the portable optimizing compiler for 8051, DS390, Z80,
HC08, and PIC microprocessors is now available (<a href="http://sdcc.sourceforge.net" target="_new">http://sdcc.sourceforge.net</a>).
Sources, documentation and binaries compiled for x86 Linux, x86 MS Windows and
universal Mac OS X are available.</p>
      <p>SDCC 2.8.0 Feature List:</p>
      <ul>
        <li>added predefined preprocessor macro SDCC_REVISION holding SDCC's subversion revision number</li>
        <li>added preprocessor macros SDCC_PARMS_IN_BANK1, SDCC_FLOAT_REENT and SDCC_INT_LONG_REENT</li>
        <li>sdcpp synchronized with GNU cpp 4.2.3</li>
        <li>multiple infiles for sdcclib</li>
        <li>added option --acall-ajmp: replaces lcall/ljmp with acall/ajmp</li>
        <li>added support for many PIC devices</li>
        <li>sdcc executables on Mac OS X are built as universal binaries, so that they can run on both ppc and i386 Mac OS X</li>
        <li>added --Werror command line option</li>
        <li>Windows installer enhancements</li>
        <li>generation of cdb debug info for as-z80 and link-z80</li>
        <li>generation of cdb debug info for variables in pdata for mcs51</li>
        <li>Tail call optimization for functions that take no parameters on Z80</li>
        <li>Improved multiplication of unsigned chars on Z80</li>
        <li>ISO/IEC 9899 standard compliant integer promotion of integer function arguments if --std-cXX is defined in command line</li>
      </ul>
      <p>Numerous feature requests and bug fixes are included as well.</p>
      <p>You can download the release from:<br />
      <a href="http://sourceforge.net/project/showfiles.php?group_id=599" target="_new">http://sourceforge.net/project/showfiles.php?group_id=599
</a></p>

      <p></p>
      <hr width="60%" />
      <p></p>

      <p><i><b>March 23th, 2008: SDCC 2.8.0 RC2 released.</b></i></p>
      <p>SDCC 2.8.0 Release Candidate 2 source, doc and binary packages for x86 Linux,
32 bit Windows and universal Mac OS X are available at:
<a href="http://sdcc.sourceforge.net/snapshots/sdcc-2.8.0-rc2">http://sdcc.sourceforge.net/snapshots/sdcc-2.8.0-rc2</a>
and <a href="http://sdcc.sourceforge.net/snap.php">http://sdcc.sourceforge.net/snap.php</a>.</p>

      <p></p>
      <hr width="60%" />
      <p></p>

      <p><i><b>March 9th, 2008: SDCC 2.8.0 RC1 released.</b></i></p>
      <p>SDCC 2.8.0 Release Candidate 1 source, doc and binary packages for x86 Linux,
32 bit Windows and universal Mac OS X are available at:
<a href="http://sdcc.sourceforge.net/snapshots/sdcc-2.8.0-rc1">http://sdcc.sourceforge.net/snapshots/sdcc-2.8.0-rc1</a>
and <a href="http://sdcc.sourceforge.net/snap.php">http://sdcc.sourceforge.net/snap.php</a>.</p>

      <p></p>
      <hr width="60%" />
      <p></p>

      <p><i><b>May 31st, 2007: Small Device C Compiler 2.7.0 released.</b></i></p>
      <p>A new release of SDCC, the portable optimizing compiler for 8051, DS390, Z80,
HC08, and PIC microprocessors is now available (<a href="http://sdcc.sourceforge.net" target="_new">http://sdcc.sourceforge.net</a>).
Sources, documentation and binaries compiled for x86 Linux, x86 MS Windows and
PPC Mac OS X are available.</p>

      <p></p>
      <hr width="60%" />
      <p></p>

      <p><i><b>May 26th, 2007: SDCC 2.7.0 RC3 released.</b></i></p>
      <p>SDCC 2.7.0 Release Candidate 3 source, doc and binary packages for x86 Linux,
32 bit Windows and ppc Mac OS X are available at:
<a href="http://sdcc.sourceforge.net/snapshots/sdcc-2.7.0-rc3">http://sdcc.sourceforge.net/snapshots/sdcc-2.7.0-rc3</a>
and <a href="http://sdcc.sourceforge.net/snap.php">http://sdcc.sourceforge.net/snap.php</a>.</p>

      <p></p>
      <hr width="60%" />
      <p></p>

      <p><i><b>May 22nd, 2007: SDCC 2.7.0 RC2 released.</b></i></p>
      <p>SDCC 2.7.0 Release Candidate 2 source, doc and binary packages for x86 Linux,
32 bit Windows and ppc Mac OS X are available at:
<a href="http://sdcc.sourceforge.net/snapshots/sdcc-2.7.0-rc2">http://sdcc.sourceforge.net/snapshots/sdcc-2.7.0-rc2</a>
and <a href="http://sdcc.sourceforge.net/snap.php">http://sdcc.sourceforge.net/snap.php</a>.</p>

      <p></p>
      <hr width="60%" />
      <p></p>

      <p><i><b>May 21st, 2007: Circuit Cellar made the Sandeep's article "Anatomy of a Compiler A Retargetable ANSI-C
Compiler" publically available</b></i></p>
      <p>Sandeep's article "Anatomy of a Compiler A Retargetable ANSI-C
Compiler", published in Circuit Cellar, issue 121, is now publicly
available at:
<a href="http://www.circuitcellar.com/SA/Articles2/Dutta-121.pdf">http://www.circuitcellar.com/SA/Articles2/Dutta-121.pdf</a>.</p>

      <p></p>
      <hr width="60%" />
      <p></p>

      <p><i><b>May 10th, 2007: SDCC 2.7.0 RC1 released.</b></i></p>
      <p>SDCC 2.7.0 Release Candidate 1 source, doc and binary packages for x86 Linux,
32 bit Windows and ppc Mac OS X are available at:
<a href="http://sdcc.sourceforge.net/snapshots/sdcc-2.7.0-rc1">http://sdcc.sourceforge.net/snapshots/sdcc-2.7.0-rc1</a>
and <a href="http://sdcc.sourceforge.net/snap.php">http://sdcc.sourceforge.net/snap.php</a>.</p>

      <p></p>
      <hr width="60%" />
      <p></p>

      <p><i><b>July 31th, 2006: Small Device C Compiler 2.6.0 released</b></i></p>
      <p>A new release of SDCC, the portable optimizing compiler for 8051, DS390, Z80, PIC, and HC08 microprocessors
is now available (<a href="http://sdcc.sourceforge.net">http://sdcc.sourceforge.net</a>). Sources, documentation
and binaries compiled for x86 Linux, x86 Microsoft Windows and PPC Mac OS X are available.</p>
      <p>This release improves the compiler's conformance to the C standard. Significant progress was also made on the
PIC (both 14- and 16-bit) backends. For the 8051 SDCC has seen the addition of a new memory model, code banking
and bit variables. Numerous feature requests and bug fixes are included as well.</p>
      <p>Since 2.5.0 the ChangeLog has grown by more than 3000 lines so all changes are simply too numerous to name.</p>
      <p>You can download the this release from:<br />
      <a href="http://sourceforge.net/project/showfiles.php?group_id=599">http://sourceforge.net/project/showfiles.php?group_id=599</a></p>

      <p></p>
      <hr width="60%" />
      <p></p>

      <p><i><b>July 28th, 2006: SDCC 2.6.0 RC2 released.</b></i></p>
      <p>SDCC 2.6.0 Release Candidate 2 packages for x86 Linux, 32 bit Windows,
ppc MacOSX and doc packages are available at: <a href="http://sdcc.sourceforge.net/snapshots/sdcc-2.6.0-rc2">http://sdcc.sourceforge.net/snapshots/sdcc-2.6.0-rc1</a>
and <a href="http://sdcc.sourceforge.net/snap.php">http://sdcc.sourceforge.net/snap.php</a>.</p>

      <p></p>
      <hr width="60%" />
      <p></p>

      <p><i><b>July 12th, 2006: SDCC 2.6.0 RC1 released.</b></i></p>
      <p>SDCC 2.6.0 Release Candidate 1 packages for x86 Linux, 32 bit Windows,
ppc MacOSX and doc packages are available at: <a href="http://sdcc.sourceforge.net/snapshots/sdcc-2.6.0-rc1">http://sdcc.sourceforge.net/snapshots/sdcc-2.6.0-rc1</a>
and <a href="http://sdcc.sourceforge.net/snap.php">http://sdcc.sourceforge.net/snap.php</a>.</p>

      <p></p>
      <hr width="60%" />
      <p></p>

      <p><i><b>April 19th, 2006: SDCC migrated from CVS to Subversion version control system.</b></i></p>

      <p></p>
      <hr width="60%" />
      <p></p>

      <p><i><b>May 12th, 2005: SDCC 2.5.0 released.</b></i></p>
      <p>Source code and binaries Microsoft Windows and Linux are available from
the <a href="http://sourceforge.net/project/showfiles.php?group_id=599">Sourceforge
download page</a>.</p>

      <p></p>
      <hr width="60%" />
      <p></p>

      <p><i><b>February 26th, 2004 - SDCC 2.4.0
released</b></i></p>
      <p>Source code and binaries for Mac OS X, Microsoft
Windows, and Linux are available from the <a href="http://sourceforge.net/project/showfiles.php?group_id=599">Sourceforge
download page</a>. SDCC has been tested on Mandrake 9.2, Windows
98, and Mac OS X with the gcc 3.3 update.</p>

      <p></p>
      <hr width="60%" />
      <p></p>

      <p><i><b>September 29, 2001 - Version 2.3.0
released</b></i></p>
      <p>Version 2.3.0 is now available. This is the first
official release in some time, and includes many bug fixes and
significantly improved Z80 support.</p>

      <p></p>
      <hr width="60%" />
      <p></p>

      <p><i><b>July 11, 2001 - Winbin updates</b></i></p>
      <p>Recently, Karl Bongers has put together a beta for win32
using pre-built cygwin
and Borland bins. You can download it <a href="ftp://sdcc.sourceforge.net/pub/sdcc/sdcc-2.2.2-7.11.01-winbin.zip">
here</a>.
Remember this is a beta build and will change from time to time.
Updates
will be posted in the <a href="index.php#Download">Download</a>
section as they become available. There will be a link in the <a href="index.php#Download">
Download</a> section for this and all future builds. Please *DO
NOT* email Karl directly
with problems. Any questions or fixes you have can be directed to the
mailing
list, see the link in the <a href="index.php#Support">Support</a>
section below.<br />
      </p>
      <p>If you run a win32 box I recommend installing Karl's
build, if only for the
ease of install. If you are a native Linux user, use the CVS tree.
Completely
remove the old source dir and do a fresh checkout.</p>
      <p>As always, there is lots going on in CVS. There are a
LOT of changes to
the documentation. This has been and always will be a short side of
OSS,
SDCC included. The developers have added a lot of new command line
switches
and made changes to the old ones. The mcs51 header files have been
removed
and replaced with a common one. RTFM and then ask questions. The Z80
port
has been updated as well. Scott has fallen off the face of the earth
and
has not been heard from for a while ;-) We'll hear of his adventures
when
he returns. Meanwhile the PIC port has remained static. Michael has
been
working on an automated build for SDCC. If you download the source
files,
this should help tremendously.</p>
      <p>There are a few bugs left that are keeping the
developers from releasing
v2.2.2. This has been said now for a long time now. You just can't rush
quality ;-) An <i>official</i> release should happen in
the next few months.</p>
      <p>Special thanks to Johan Knol for keeping the ball
rolling while everyone
is working their paying jobs.</p>

      <p></p>
      <hr width="60%" />
      <p></p>

      <p><i><b>April 24, 2001 - Notes</b></i></p>
      <p>There has been a <i><b>lot</b></i>
of updates to v2.2.2 CVS lately. v2.2.1
is comparatively old and we recommend you download a binary
build from the <a href="http://www.qsl.net/dl9sec/SDCC_OKR.html">OKR</a>
or update your sources from CVS. Mitja Kukovec has sent the mailing
list
some short instructions on installing Cygwin on a Win32 box, the link
to
the text is in the SUPPORT section.</p>

      <p></p>
      <hr width="60%" />
      <p></p>

      <p><i><b>February 20, 2001 - Pic Port</b></i></p>
      <p>Scott has been making great strides on the pic port.
There are a lot of issues
with bringing his work into other branches of SDCC, so you will not see
all
of the features of his port in the avr and mcs51 trees. Scott has been
working
on generating intermediate 'pcode' that will be used for code
optimizations
and linker features. This is a major step and there are bound to be
problems...
on the cutting edge you might get cut every once in a while. This has
not
been implemented in any of the other trees, but if he pulls this off,
you
will see better and more flexible code come out of SDCC. We think it's
just
a matter of time ;-) Tip-o-the-hat to Scott.</p>
      <p>Sandeep's daytime job keeps him from doing as much as he
would like, but
he pops in from time to time with fixes and other contributions.
Everyone
involved with the project has been very active lately, we are a lot
closer
to an <i>official</i> 2.2.2 release. As always, the above
can be had from
cvs. It would be a good idea to do a fresh check-out from cvs rather
than
an update as a LOT of things have changed. Binary builds from recent
cvs
sources can be downloaded from the <a href="http://www.qsl.net/dl9sec/SDCC_OKR.html">
OKR</a>
.</p>

      <p></p>
      <hr width="60%" />
      <p></p>

      <p><i><b>January 25, 2001 -- SDCC v2.2.2 is still in CVS</b></i></p>
      <p>Due to numerous additions to SDCC to support the Dallas
DS'390, Version 2.2.2
has been delayed until more bugs are squashed. Kevin and Johan are
working
on them all the time ;-) Lots of help from the user and development
mailing
lists too.</p>
      <p>Some (if not all) of SDCC users will be glad to know
that Scott Dattalo has
been porting SDCC to the 14bit versions of the Microchip PIC
controller.
His port is still in its early stages and needs a lot of work but it
does
compile programs. His code has been committed to cvs on sourceforge and
is
included when you update your cvs directories.</p>

      <p></p>
      <hr width="60%" />
      <p></p>

      <p><i><b>SDCC v2.2.1 is out!!! Check it out in
the <a href="/index.php#download">download</a> section<br />
      </b></i></p>
      <p>This is a milestone release for the development group.<br />
New stuff includes:</p>
      <ul>
        <li>bug fixes (always bug fixes) </li>
        <li>better support for the Dallas '390, flat memory model
is a lot better than
before, not perfect. </li>
        <li>changes to the assembler </li>
        <li>better documentation </li>
        <li>faster compile times </li>
        <li>and more... </li>
      </ul>
      <p>There are more new command line switches to SDCC.. PAY
ATTENTION! Read the
documentation!</p>
      <p>There have been additions to the SDCC developer team, we
would like to welcome</p>
      <p>Kevin Vigor and Johan Knol<br />
And now... Scott Dattalo<br />
      </p>

      <p></p>
      <hr width="60%" />
      <p></p>

      <p><i><b>V2.2.1 is in CVS</b></i></p>
      <p><i><b>(Sept 17,2000) </b></i>The
latest version SDCC is in CVS at the moment. Michael Schmitt has been
making releases and posting them to the supporting web sites,
specifically the <a href="http://www.qsl.net/dl9sec/SDCC_OKR.htm">OKR</a>
. As always... the most recent source code is here on Sourceforge. A
lot of work is going into the flat 24bit model and the Dallas '390
processor by Kevin Vigor. Kevin has been committing updates and fixes
almost on a daily basis. '390 support is looking good. As soon as all
the "known" bugs have been squashed, a release will be posted here in
the download section.</p>
      <p>If you are using SDCC on a win32/Cygwin platform, be aware you
will also need 'binutils' from the CVS tree.<br />
Once logged into CVS do: cvs -z3 co binutils-avr<br />
      </p>
      <p>Some users are experiencing problems with win32/Cygwin logging
into cvs. Compatibility issues on Cygwin and win32 versions of cvs will
be posted soon. I will be contacting Cygnus to see if we can post the
known working version of Cygwin here on Sourceforge.</p>
      <p>AVR support is continuing. Sandeep expects a usable build
sometime before the end of October.</p>

      <p></p>
      <hr width="60%" />
      <p></p>

      <p><i><b>V2.2.0 is now released. </b></i></p>
      <p><i><b>(Feb 27,2000)</b></i> SDCC
v2.2.0 is coming soon. As of February 27, 2000, work on v2.2.0 is
moving along but there are still a few compile problems to be worked
out. This will be a big step in the development of SDCC as it will now
support the Z80 with support for the Atmel AVR right behind it. The
next few 2.x releases will be mostly bug fixes (if there are any ;-)
and speed improvements.</p>
      <p>SDCC now has limited support for the Dallas DS80C390
microprocessor using the --model-flat24 option. This is a processor
from Dallas Semiconductor which starts up in 8051 code compatible mode,
but has a new mode which allows direct, non-paging use of up to 4
megabytes of code and data space.The TINI board from Dallas uses this
processor and includes 512kbytes flash, ram + Ethernet on a small simm
stick board for $50.00. See <a href="http://www.ibutton.com">http://www.ibutton.com</a>
TINI for details.</p>
      <p>As of the first week in April, <a href="http://www.systronix.com">Systronics</a> is now
shipping backorders for the STEP, STEP+, and the TINI. (Dallas must be
selling a ton of the TINI's. I have one of the STEP+TINI kits and love
it... I just finished getting an http server up and running on it)</p>
      <h2>Previous Versions</h2>
      <p>Released March 27, 2000</p>
      <ul>
        <li><a href="files/v2.2.0/sdcc-2.2.0a.tar.gz">SDCC
v2.2.0a Source (in gzipped tar format) [2.3M]</a> </li>
        <li><a href="files/v2.2.0/sdcc-2.2.0a.winbin.tar.gz">SDCC
v2.2.0a Win32 Binary (in gzipped tar format) [2.3M]</a> </li>
        <li><a href="files/v2.2.0/sdccdoc.tar.gz">SDCC
v2.2.0a Documentation [160K]</a></li>
      </ul>
      <p>Released January 20, 2000</p>
      <ul>
        <li><a href="ftp://sdcc.sourceforge.net/sdcc/pub/sdcc-2.1.9Ga.tar.gz">version
2.1.9Ga Source (in gzipped tar format)</a> </li>
        <li><a href="ftp://sdcc.sourceforge.net/sdcc/pub/sdcc-2.1.9Gawinbin.tar.gz">version
2.1.9Ga Win32 Binary (in gzipped tar format)</a> </li>
      </ul>
      <p>All are gzipped tar archives.</p>
<?php include('./footer.php')?>
      </td>
    </tr>
  </tbody>
</table>
</div>
</body>
</html>
