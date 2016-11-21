<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="content-type" />
    <meta name="keywords" content="68hc08 8032 8051 ansi c compiler assembler CPU DS390 embedded development Floating Point Arithmetic free Freescale GPL HC08 inline Intel ISO/IEC 9899:1990 Linux MAC OS X OSX manual Maxim mcs51 Microchip microcontroller open source PIC Unix Windows XP Z80 Zilog TLCS-90 STMicroelectronics STM8" />
    <title>SDCC - Small Device C Compiler</title>
    <link type="text/css" href="styles/style.css" rel="stylesheet" />
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

            <h2>What is SDCC?</h2>

            <p><b>SDCC</b> is a <b><i>retargettable, optimizing Standard C (ANSI C89, ISO C99, ISO C11) compiler suite</i></b> that
              targets the <b><i>Intel MCS51 </i></b> based microprocessors <b><i>(8031, 8032, 8051, 8052, etc.)</i></b>,
              <b><i>Maxim</i></b> (formerly <b><i>Dallas</i></b>) <b><i>DS80C390</i></b> variants,
              <b><i>Freescale</i></b> (formerly <b><i>Motorola</i></b>) <b><i>HC08</i></b> based <b><i>(hc08, s08)</i></b>,
              <b><i>Zilog Z80</i></b> based MCUs <b><i>(z80, z180, gbz80, Rabbit 2000/3000, Rabbit 3000A, TLCS-90)</i></b> and
			  <b><i>STMicroelectronics STM8</i></b>.
              Work is in progress on supporting the <b><i>Microchip PIC16</i></b> and <b><i>PIC18</i></b>
              targets. It can be retargeted for other microprocessors.</p>
           <p>SDCC suite is a collection of several components derived from different sources with
              different FOSS licenses. SDCC compiler suite include:</p>
            <ul>
              <li><b>sdas</b> and <b>sdld</b>, a <i>retargettable assembler and linker</i>, based on <b>ASXXXX</b>, written by Alan Baldwin; (GPL).</li>
              <li><b>sdcpp</b> <i>preprocessor</i>, based on <b>GCC cpp</b>; (GPL).</li>
              <li><b>ucsim</b> <i>simulators</i>, originally written by Daniel Drotos; (GPL).</li>
              <li><b>sdcdb</b> <i>source level debugger</i>, originally written by Sandeep Dutta; (GPL).</li>
              <li><b>sdbinutils</b> <i>library archive utilities</i>, including sdar, sdranlib and sdnm, derived from GNU Binutils; (GPL)</li>
              <li><b>SDCC run-time libraries</b>; (GPL+LE). Pic device libraries and header files are derived from Microchip header (.inc) and linker script (.lkr) files. Microchip requires that "The header files should state that they are only to be used with authentic Microchip devices" which makes them incompatible with the GPL.</li>
              <li><b>gcc-test</b> <i>regression tests</i>, derived from  <b>gcc-testsuite</b>; (no license explicitely specified, but since it is a part of GCC is probably GPL licensed)</li>
              <li><b>packihx</b>; (public domain)</li>
              <li><b>makebin</b>; (zlib/libpng License)</li>
              <li><b>sdcc</b> <i>C compiler</i>, originally written by Sandeep Dutta; (GPL). Some of the features include:
              <ul>
                <li>extensive MCU specific language extensions, allowing effective use of the underlying hardware.</li>
                <li>a host of standard optimizations such as <i>global sub expression
                  elimination, loop optimizations (loop invariant, strength reduction of induction
                  variables and loop reversing), constant folding </i>and<i> propagation,
                  copy propagation, dead code elimination and jump tables for 'switch' statements.</i></li>
                <li>MCU specific optimizations, including a global register allocator.</li>
                <li>adaptable MCU specific backend that should be well suited for other 8 bit MCUs</li>
                <li>independent rule based peep hole optimizer.</li>
                <li>a full range of data types: <b>char</b> (<i>8</i> bits, 1 byte), <b>short</b> (<i>16</i> bits, 2 bytes),
                  <b>int</b> (<i>16</i> bits, 2 bytes), <b>long</b> (<i>32</i> bit, 4 bytes), <b>float</b> (4 byte IEEE) and
                  <b>_Bool</b>/<b>bool</b>;<br />
                  support for <b>long long</b> (<i>64</i> bit, 8 bytes) data types for the z80, z180,
                  r2k, r3ka, gbz80, hc08, s08 and stm8 targets.</li>
                <li>the ability to add inline assembler code anywhere in a function.</li>
                <li>the ability to report on the complexity of a function to help decide what should be re-written in assembler.</li>
                <li>a good selection of automated regression tests.</li>
              </ul></li>
            </ul>
            <p><b>SDCC</b> was written by Sandeep Dutta and released under a <b>GPL</b> license.
              Since its initial release there have been numerous bug fixes and improvements.
              As of December 1999, the code was moved to SourceForge where all the "users
              turned developers" can access the same source tree. SDCC is constantly being
              updated with all the users' and developers' input.</p>

            <!-- START NEWS -->
            <h2><a name="News"></a>News</h2>

            <p><i><b>June 12th, 2016: Small Device C Compiler 3.6.0 released.</b></i></p>
            <p>A new release of SDCC, the portable optimizing compiler for 8051, DS390, Z80, Z180, Rabbit 2000,
              HC08, STM8 and PIC microprocessors is now available
              (<a href="http://sdcc.sourceforge.net" target="_new">http://sdcc.sourceforge.net</a>).
              Sources, documentation and binaries compiled for x86 Linux, x86 and x64 MS Windows and
              x86 and PPC Mac OS X are available. </p>
            <p>SDCC 3.6.0 Feature List:</p>
            <ul>
              <li>Merged upstream binutils 2.25</li>
              <li>New memory management with lower overhead</li>
              <li>Changed default language dialect to --std-sdcc11</li>
              <li>Diagnostic for missing type specifier: No implicit int outside of C90 mode anymore</li>
              <li>C11 generic selections</li>
              <li>char type is now unsigned by default (old behaviour can be restored using --fsigned-char)</li>
              <li>Character constants are now of type int instead of char.</li>
              <li>ISO C95 and ISO C11 wide character constants</li>
              <li>ISO C95 and ISO C11 wide string literals</li>
              <li>Basic standard library support for wide characters: c16rtomb(), mbrtoc16(), mbsinit(), mbtowc(), mbrlen(), mbrtoc32, c32rtomb(), mbrtowc(), wcrtomb(), mblen(), wctomb()</li>
              <li>Treat all ports the same in the manual (i.e. mcs51-specific stuff is now clearly described as such)</li>
              <li>Reorganized interrupt handling for z80, z180, r2k, r3ka, tlcs90, gbz80 backends</li>
              <li>Workaround for stm8 division hardware bug</li>
              <li>ELF/DWARF support for stm8</li>
              <li>Output symbol table for ELF</li>
              <li>pic16 port now uses standard-compliant crt0iz that initializes static and globals to 0 by default</li>
            </ul>
            <p>Numerous feature requests and bug fixes are included as well.</p>
            <p>You can download the release from:<br />
              <a href="https://sourceforge.net/projects/sdcc/files/" target="_new">https://sourceforge.net/projects/sdcc/files/</a></p>

            <!-- END NEWS -->

            <h2><a name="Platforms"></a>What Platforms are Supported?</h2>

            <p><b>Linux - x86</b>, <b>Microsoft Windows - x86</b>, <b>Microsoft Windows - x86_64</b> and <b>Mac OS X</b>
              are the primary, so called "officially supported" platforms.</p>
            <p><b>SDCC</b> compiles natively on <b>Linux</b> and <b>Mac OS X</b>
              using <a href="http://www.gnu.org">gcc</a>. <b>Windows</b> release and snapshot builds are made by
              <b>cross compiling to mingw32</b> on a Linux host.</p>
            <p><b>Windows 9x/NT/2000/XP/Vista/7/8</b> users are
              recommended to use Cygwin (<a href="http://sources.redhat.com/cygwin/">http://sources.redhat.com/cygwin/</a>)
              or may try the unsupported Microsoft Visual C++ build scripts.</p>

            <h2><a name="Download"></a>Downloading SDCC</h2>

            <p>See the <a href="https://sourceforge.net/projects/sdcc/files/">
              Sourceforge download page</a> for the last released version including source and
              binary packages for <b>Linux - x86</b>, <b>Microsoft Windows - x86</b>,
              <b>Microsoft Windows - x86_64</b> and <b>Mac OS X - ppc and i386</b>.</p>
            <p>Major Linux distributions take care of SDCC installation packages themselves
              and you will find SDCC in their repositories. Unfortunately SDCC packages included
              in Linux disributions are often outdated. In this case users are encouraged to compile
              the latest official SDCC release or a recent snapshot build by themselves or download
              the pre-compiled binaries from
              <a href="https://sourceforge.net/projects/sdcc/files/">
              Sourceforge download page</a>.</p>
            <p>SDCC is known to compile from the source code also on the following platforms:</p>
            <ul>
              <li>Linux - x86_64</li>
              <li>Linux - Alpha</li>
              <li>Linux - IBM Power5</li>
              <li>NetBSD - i386</li>
              <li>NetBSD - Sparc64</li>
              <li>FreeBSD - i386</li>
              <li>SUN Solaris - i386</li>
              <li>SUN Solaris - Sparc</li>
              <li>Rasbian (Debian for Raspberry Pi) - ARMv6</li>
              <li>Debian - ARMv7-a</li>
            </ul>
            <p>SDCC is always under active development. Please consider
              <a href="snap.php">downloading one of the snapshot builds</a>
              if you have run across a bug, or if the above release is more than two months old.</p>
            <p>The latest development source code can be accessed using Subversion. The following
              will fetch the latest sources:</p>
            <p><code>svn checkout svn://svn.code.sf.net/p/sdcc/code/trunk/sdcc sdcc</code></p>
            <p>... will create the <i>sdcc</i> directory in your current directory and place all
              downloaded code there. You can browse the Subversion repository
              <a href="https://sourceforge.net/p/sdcc/code/HEAD/tree/trunk/sdcc/">here</a>.</p>
            <!-- <p>SourceForge has further documentation on accessing the Subversion repository
              <a href="https://sourceforge.net/scm/?type=svn&amp;group_id=599">here</a>.</p> -->
            <p>Before reporting a bug, please check your SDCC version and build
              date using the -v option, and be sure to include the full version string in your bug report. For example:</p>
            <p><code>sdcc/bin &gt; sdcc -v<br />
              SDCC : mcs51/gbz80/z80/avr/ds390/pic14/TININative/xa51 2.3.8 (Feb 10 2004) (UNIX)</code></p>

            <h2><a name="Support"></a>Support for SDCC</h2>

            <p><b>SDCC</b> and the included support packages come with fair amounts of documentation
              and examples. When they aren't enough, you can find help in the
              places listed below. Here is a short check list of tips to greatly improve your
              chances of obtaining a helpful response.</p>
            <ol>
              <li>Attach the code you are compiling with SDCC. It should compile "out of the box".
                Snippets must compile and must include any required header files, etc.
                Incomplete information will hamper your chance of a timely response.</li>
              <li>Specify the exact command you use to run SDCC, or attach your Makefile.</li>
              <li>Specify the SDCC version (type "sdcc -v"), your platform and operating system.</li>
              <li>Provide an exact copy of any error message or incorrect output.</li>
            </ol>
            <p><b>Please attempt to include these 4 important parts</b>,
              as applicable, in all requests for support or when reporting any problems or bugs
              with SDCC. Though this will make your message lengthy, it will greatly improve your
              chance that SDCC users and developers will be able to help you. Some SDCC developers
              are frustrated by bug reports without code provided that they can use to reproduce
              and ultimately fix the problem, so please be sure to provide sample code if you are
              reporting a bug!</p>
            <ul>
              <li><a href="http://sdcc.sourceforge.net">Web Page</a> - you are (X) here.</li>
              <li>Mailing list: [use "BUG REPORTING" below if you believe you have found a bug.]
                <ul>
                  <li>Send to the developer list &lt;sdcc-devel.AT.lists.sourceforge.net&gt; -
                    for development work on SDCC</li>
                  <li>Send to the user list &lt;sdcc-user.AT.lists.sourceforge.net&gt; -
                    [preferred] all developers and all users.</li>
                  <li><a href="http://lists.sourceforge.net/mailman/listinfo/sdcc-user">
                    Subscribe to the user list</a></li>
                </ul>
              </li>
              <li><a href="https://sourceforge.net/p/sdcc/bugs/new/">
                Bug Reporting</a> - if you have a problem using SDCC, we need to
                hear about it. Please attach <b>code to reproduce the problem</b>,
                and be sure to provide your email address so a developer can contact
                you if they need more information to investigate and fix the bug.</li>
              <li><a href="https://sourceforge.net/p/sdcc/webdocs/new/">
                Website/Documentation Issues</a> - Please report erroneous, missing or outdated
                information</li>
              <li><a href="https://sourceforge.net/p/sdcc/discussion/1864/">
                SDCC Message Forum</a> - an account on Sourceforge is needed if you're going to
                post and reply. Short easy online fill-in the blanks.</li>
              <li><a href="http://sdccokr.dl9sec.de/">Open Knowledge Web Site</a> -
                Run by Thorsten Godau &lt;thorsten.godau.AT.gmx.de&gt;</li>
            </ul>

            <h2><a name="Who"></a>Who is SDCC?</h2>

            <ul>
              <li>Sandeep Dutta &lt;sandeep.AT.users.sourceforge.net&gt; - original author (SDCC's version of Torvalds)</li>
              <li>Jean Loius-VERN &lt;jlvern.AT.writeme.com&gt; - substantial improvement in the back-end code generation.</li>
              <li>Daniel Drotos &lt;drdani.AT.mazsola.iit.uni-miskolc.hu&gt; - Freeware simulator for 8051.</li>
              <li>Kevin Vigor &lt;kevin.AT.vigor.nu&gt; - numerous enhancements and bug fixes to the Dallas ds390 tree.</li>
              <li>Johan Knol &lt;johan.knol.AT.users.sourceforge.net&gt; - testing and patching ds390 tree, bug stompper extrodanaire</li>
              <li>Scott Dattalo &lt;scott.AT.dattalo.com&gt; - sdcc for Microchip PIC controller target</li>
              <li>Karl Bongers &lt;karl.AT.turbobit.com&gt; - mcs51 support, winbin builds, and an occasional bug.</li>
              <li>Bernhard Held &lt;bernhard.AT.bernhardheld.de&gt; - snpshot builds and general housekeeping</li>
              <li>Frieder Ferlemann &lt;Frieder.Ferlemann.AT.web.de&gt; - contributions to the documentation and last stages
                of code generation</li>
              <li>Jesus Calvino-Fraga &lt;jesusc.AT.ece.ubc.ca&gt; - math functions, AOMF51, linker improvements</li>
              <li>Borut Ražem &lt;borut.razem.AT.gmail.com&gt; - WIN32 MSC, cygwin and mingw ports, NSIS installer,
                preprocessor and front end improvements, bug fixing, snapshot builds on Distibuted Compile Farm, ...</li>
              <li>Vangelis Rokas &lt;vrokas.AT.otenet.gr&gt; - PIC16 taget development for Microchip PIC18F microcontrollers</li>
              <li>Erik Petrich &lt;epetrich.AT.users.sourceforge.net&gt; - Bug fixes and improvements for the front end,
                8051, z80 and hc08</li>
              <li>Dave Helton &lt;dave.AT.kd0yu.com&gt; - website design</li>
              <li>Paul Stoffregen &lt;paul.AT.pjrc.com&gt; - mcs51 optimizations and website maintenance.</li>
              <li>Michael Hope &lt;michaelh.AT.juju.net.nz&gt; - initial Z80 target, additional coding and bug fixes.</li>
              <li>Maarten Brock &lt;sourceforge.brock.AT.dse.nl&gt; - several bug fixes and improvements, esp. for mcs51 target</li>
              <li>Raphael Neider &lt;RNeider.AT.web.de&gt; - bug fixes and optimizations for PIC16, completion of the PIC14 target</li>
              <li>Philipp Klaus Krause &lt;pkk.AT.spth.de&gt; - work on the STM8,Z80,Z180,Rabbit,GBZ80,TLCS-90 backends, compiler research</li>
              <li>Leland Morrison &lt;enigmalee.AT.sourceforget.net&gt; - Rabbit 2000 support: the target code generator,
                sdasrab assembler and ucsim support</li>
              <li>Molnár Károly &lt;molnarkaroly.AT.users.sf.net&gt; - adding pic devices, developing and maintaining pic device files
                generation scripts</li>
              <li>Ben Shi &lt;powerstudio1st.AT.163.com&gt; - the front-end, the STM8 back-end, and the MCS-51 back-end maintain</li>
            </ul>
            <p>SDCC has had help from a number of external sources, including:</p>
            <ul>
              <li>Alan Baldwin &lt;baldwin.AT.shop-pdp.kent.edu&gt; - Initial version of ASXXXX&nbsp; and&nbsp; ASLINK.</li>
              <li>John Hartman &lt;noice.AT.noicedebugger.com&gt; - Porting ASXXXX and ASLINK for 8051.</li>
              <!-- <li>Jans J Boehm &lt;boehm.AT.sgi.com&gt; and Alan J Demers - Conservative garbage collector for C &amp; C++.</li> -->
              <li>Dmitry S. Obukhov &lt;dso.AT.usa.net&gt; - malloc and serial I/O routines.</li>
              <li>Pascal Felber - Some of the Z80 related files are borrowed from the Gameboy Development Kit (GBDK).</li>
              <li><a href="http://gcc.gnu.org/">The GCC development team</a> - for GNU C preprocessor,
                the basis of sdcpp preprocessor and gcc test suite, partially included into the SDCC regression test suite </li>
              <li><a href="http://www.gnu.org/software/binutils/">The GNU Binutils development team</a> - for GNU Binutils,
                the basis of sdbinutils</li>
              <li><a href="http://www.boost.org/">Boost Community</a> - for Boost C++ libraries used in sdcc compiler</li>
              <li><a href="http://idlebox.net/2007/stx-btree/">Timo Bingmann</a> - for STX B+ Tree C++ Template Classes
                used in sdcc compiler</li>
              <li>Malini Dutta &lt;malini.AT.mediaone.net&gt; - Sandeep's wife, for her patience and support.</li>
            </ul>

            <!-- START PAST_NEWS -->

            <h2><a name="Past_news"></a>Past news</h2>

            <p><i><b>June 5th, 2016: SDCC 3.6.0 RC2 released.</b></i></p>
            <p>SDCC 3.6.0 Release Candidate 2 source, doc and binary packages for x86 Linux,
              32 and 64 bit Windows and universal Mac OS X are available in corresponding folders at:
              <a href="http://sourceforge.net/projects/sdcc/files/">
              http://sourceforge.net/projects/sdcc/files/</a>.</p>

            <p><i><b>May 30th, 2016: SDCC 3.6.0 RC1 released.</b></i></p>
            <p>SDCC 3.6.0 Release Candidate 1 source, doc and binary packages for x86 Linux,
              32 and 64 bit Windows and universal Mac OS X are available in corresponding folders at:
              <a href="http://sourceforge.net/projects/sdcc/files/">
              http://sourceforge.net/projects/sdcc/files/</a>.</p>

            <!-- END PAST_NEWS -->

            <p><a href="previous.php">Previous News</a></p>

<?php include('./footer.php')?>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </body>
</html>
