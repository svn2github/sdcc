<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
  <meta content="text/html; charset=UTF-8" http-equiv="content-type" />
  <meta name="keywords" content="68hc08 8032 8051 ansi c compiler assembler CPU DS390 embedded development Floating Point Arithmetic free Freescale GPL HC08 inline Intel ISO/IEC 9899:1990 Linux MAC OS X OSX manual Maxim mcs51 Microchip microcontroller open source PIC Unix Windows XP Z80 Zilog" />
  <title>SDCC - Small Device C Compiler</title>
  <link type="text/css" href="style.css" rel="stylesheet" />
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
      <p> <b>SDCC</b> is a <b><i>retargettable, optimizing ANSI - C compiler</i></b> that
targets the <b><i>Intel 8051, Maxim 80DS390, Zilog Z80</i></b>
and the <b><i>Motorola 68HC08</i></b> based MCUs.
Work is in progress on supporting the <b><i>Microchip
PIC16</i></b> and <b><i>PIC18</i></b> series. SDCC is a Free Open Source Software, distributed under GNU General Public License (GPL). </p>
      <p>Some of the features include: </p>
      <ul>
        <li>ASXXXX and ASLINK, a Freeware, retargettable
assembler and
linker.</li>
        <li>extensive MCU specific language extensions,
allowing effective use of the underlying hardware.</li>
        <li>a host of standard optimizations such as <i>global
sub expression
elimination, loop optimizations (loop invariant, strength reduction of
induction
variables and loop reversing ), constant folding </i>and<i>
propagation,
copy propagation, dead code elimination and jump tables for 'switch'
statements.</i> </li>
        <li>MCU specific optimizations, including a global
register allocator.</li>
        <li>adaptable MCU specific backend that should be well
suited for other 8
bit MCUs</li>
        <li>independent rule based peep hole optimizer.</li>
        <li>a full range of data types: <b>
char </b>(<i>8</i> bits, 1 byte), <b>short </b>(<i>16</i>
bits, 2
bytes), <b>int</b> (<i>16</i> bits, 2 bytes), <b>long
          </b> (<i>32</i> bit, 4
bytes)
and <b>
float </b> (<i>4</i> byte IEEE). </li>
        <li>the ability to add inline assembler code anywhere in
a function.</li>
        <li>the ability to report on the complexity of a function
to help decide what
should be re-written in assembler.</li>
        <li>a good selection of automated regression tests.</li>
      </ul>
      <p><b>SDCC</b>
also comes with the <i>source level debugger</i><b>
SDCDB</b>, using the current version of Daniel's s51 simulator. </p>
      <p> <b>SDCC</b> was written by Sandeep Dutta
and released under a <b>GPL</b>
license. Since its
initial release there have been numerous bug fixes and improvements. As
of
December 1999, the code was moved to SourceForge where all the "users
turned
developers" can access the same source tree. SDCC is constantly being
updated
with all the users' and developers' input. </p>
      <p><b><i>AVR</i></b>
and <b><i>gbz80</i></b>
ports are no longer maintained. </p>
      <h2><a name="News"></a>News</h2>
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
      <h2><a name="Platforms"></a>What Platforms are Supported?</h2>
      <p><b>Linux - x86</b>, <b>Microsoft Windows - x86</b> and <b>Mac OS x - ppc</b>
are the primary, so called "officially supported" platforms.</p>
      <p><b>SDCC</b> compiles natively on <b>Linux</b> and <b>Mac OS X</b>
using using <a href="http://www.gnu.org">gcc</a>. <b>Windows</b> release and snapshot builds are made by <b>cross compiling to mingw32</b> on a Linux host.</p>
      <p><b>Windows 9x/NT/2000/XP</b> users are
recommended to use Cygwin (<a href="http://sources.redhat.com/cygwin/">http://sources.redhat.com/cygwin/</a>)
or may try the unsupported Borland C compiler or Microsoft Visual C++ build
scripts.</p>
      <h2><a name="Download"></a>Downloading SDCC</h2>
      <p>See the <a href="http://sourceforge.net/project/showfiles.php?group_id=599">Sourceforge
download page</a> for the last released version including source
and binary packages for <b>Linux - x86</b>,
      <b>Microsoft Windows - x86</b> and <b>Mac OS x - ppc</b>.</p>
      <p>SDCC is known to compile from the source code also on <b>Linux - x86_64</b>,
      <b>Linux - Alpha</b>,
      <b>Linux - IBM Power5</b>,
      and <b>SUN Solaris - Sparc</b>.
      </p>
      <p>SDCC is always under active development. Please consider
      <a href="snap.php">downloading one of the snapshot builds</a>
if you have
run across a bug, or if the above release is more than two months old. </p>
      <p> Debian packages (many thanks to <a href="mailto:aurel32.AT.debian.org">Aurelien Jarno</a>):
      </p>
      <ul>
        <li> <a href="http://packages.debian.org/sdcc">http://packages.debian.org/sdcc</a>
        </li>
        <li> <a href="http://ftp.debian.org/debian/pool/main/s/sdcc/">http://ftp.debian.org/debian/pool/main/s/sdcc/</a>
        </li>
      </ul>
      <p>RPM packages (thanks to Mandrake, Conectiva and PLD
Linux
distributions): </p>
      <ul>
        <li> <a href="http://www.rpmseek.com/">http://www.rpmseek.com/</a>
        </li>
        <li> <a href="http://rpmfind.net/">http://rpmfind.net/</a>
        </li>
      </ul>
      <p>The latest development source code can be accessed using
Subversion. The following will fetch the latest sources:<br />
      <br />
      <code>
        svn co https://svn.sourceforge.net/svnroot/sdcc/trunk/sdcc sdcc
      </code><br />
      <br />
... will create the <i>sdcc</i> directory in your current directory and place all
downloaded code there. You can browse the Subversion repository
      <a href="https://sdcc.svn.sourceforge.net/svnroot/sdcc/trunk/sdcc/">here</a>. </p>
      <p>SourceForge has further documentation on accessing the Subversion repository
      <a href="http://sourceforge.net/docman/display_doc.php?docid=31070&amp;group_id=1">here</a>. </p>
      <p>Before reporting a bug, please check your SDCC version
and build
date using the -v option, and be sure to include the full version
string in
your bug report. For example: </p>
      <p><code>sdcc/bin &gt; sdcc -v<br />
SDCC : mcs51/gbz80/z80/avr/ds390/pic14/TININative/xa51 2.3.8 (Feb 10
2004) (UNIX) </code></p>
      <h2><a name="Support"></a>Support for SDCC</h2>
      <p><b>SDCC</b> and the included support
packages come with fair amounts of documentation
and examples. When they aren't enough, you can find help in the
places listed below. Here is a short check list of tips to greatly
improve your
chances of obtaining a helpful response. </p>
      <ol>
        <li>Attach the code you are compiling with SDCC. It
should compile "out of the box". Snippets must compile and must include
any required header files, etc.
Incomplete information will hamper your chance of a timely response. </li>
        <li>Specify the exact command you use to run SDCC, or
attach your Makefile. </li>
        <li>Specify the SDCC version (type "sdcc -v"), your
platform and operating system. </li>
        <li>Provide an exact copy of any error message or
incorrect output. </li>
      </ol>
      <p> <b>Please attempt to include these 4 important
parts</b>,
as applicable, in all requests
for support or when reporting any problems or bugs with SDCC. Though
this will make your
message lengthy, it will greatly improve your chance that SDCC users
and developers will
be able to help you. Some SDCC developers are frustrated by bug reports
without code
provided that they can use to reproduce and ultimately fix the problem,
so please be
sure to provide sample code if you are reporting a bug! </p>
      <ul>
        <li><a href="http://sdcc.sourceforge.net">Web
Page</a> , you are (X) here. </li>
        <li>Mailing list: [use "BUG REPORTING" below if you
believe you have found a
bug.]
          <ul>
            <li><a href="mailto:sdcc-devel@lists.sourceforge.net">Send to the
developer list</a> - for development work on SDCC </li>
            <li><a href="mailto:sdcc-user@lists.sourceforge.net">Send to the
user list</a> - [preferred] all developers and all users. </li>
            <li><a href="http://lists.sourceforge.net/mailman/listinfo/sdcc-user">Subscribe
to the user list</a> </li>
          </ul>
        </li>
        <li><a href="http://sourceforge.net/bugs/?func=addbug&amp;group_id=599">Bug
Reporting</a> - if you have a problem using SDCC, we need to
hear about it. Please attach <b>code to reproduce the problem</b>,
and be sure to provide your email address so a developer can contact
you if they need more information to investigate and fix the bug. </li>
        <li><a href="http://sourceforge.net/tracker/?func=add&amp;group_id=599&amp;atid=536150">Website/Documentation
Issues</a> - Please report erroneous,
missing or outdated information </li>
        <li><a href="https://sourceforge.net/forum/forum.php?forum_id=1864&amp;et=0">SDCC
Message Forum</a> - an account on Sourceforge is needed if you're
going to post and reply. Short
easy online fill-in the blanks. </li>
        <li><a href="http://sdccokr.dl9sec.de/">Open
Knowledge Web Site</a> - Run by <a href="mailto:thorsten.godau.AT.gmx.de">Thorsten Godau</a>
        </li>
      </ul>
      <h2><a name="Who"></a>Who is SDCC?</h2>
      <ul>
        <li><a href="mailto:sandeep.AT.users.sourceforge.net">Sandeep
Dutta &lt;sandeep.AT.users.sourceforge.net&gt;</a>
- original author (SDCC's version of Torvalds)</li>
        <li><a href="mailto:jlvern.AT.writeme.com">Jean
Loius-VERN &lt;jlvern.AT.writeme.com&gt;</a> -
substantial improvement in the back-end code generation.</li>
        <li><a href="mailto:drdani.AT.mazsola.iit.uni-miskolc.hu">Daniel
Drotos &lt;drdani.AT.mazsola.iit.uni-miskolc.hu&gt;</a>
- Freeware simulator for 8051.</li>
        <li><a href="mailto:kevin.AT.vigor.nu">Kevin
Vigor &lt;kevin.AT.vigor.nu&gt;</a>
- numerous enhancements and bug fixes to the Dallas ds390 tree.</li>
        <li><a href="mailto:johan.knol.AT.users.sourceforge.net">Johan Knol
&lt;johan.knol.AT.users.sourceforge.net&gt;</a>
- testing and patching ds390 tree, bug stompper extrodanaire</li>
        <li><a href="mailto:scott.AT.dattalo.com">Scott
Dattalo &lt;scott.AT.dattalo.com&gt;</a> -
Microchip PIC controller port of sdcc</li>
        <li><a href="mailto:karl.AT.turbobit.com">Karl
Bongers &lt;karl.AT.turbobit.com&gt;</a> - mcs51
support, winbin builds, and an occasional bug.</li>
        <li><a href="mailto:bernhard.AT.bernhardheld.de">Bernhard
Held &lt;bernhard.AT.bernhardheld.de&gt;</a>
- snpshot builds and general housekeeping</li>
        <li><a href="mailto:Frieder.Ferlemann.AT.web.de">Frieder
Ferlemann &lt;Frieder.Ferlemann.AT.web.de&gt;</a>
- contributions to the documentation and last stages of code generation</li>
        <li><a href="mailto:jesusc.AT.ece.ubc.ca">Jesus
Calvino-Fraga &lt;jesusc.AT.ece.ubc.ca&gt;</a>
- math functions, AOMF51, linker improvements</li>
        <li><a href="mailto:borut.razem.AT.siol.net">Borut
Ražem &lt;borut.razem.AT.siol.net&gt;</a>
- WIN32 MSC and cygwin port, NSIS installer, preprocessor and front end
improvements, bug fixing, snapshot builds, ...</li>
        <li><a href="mailto:vrokas.AT.otenet.gr">Vangelis
Rokas &lt;vrokas.AT.otenet.gr&gt;</a>
- PIC16 port development for Microchip PIC18F microcontrollers</li>
        <li><a href="mailto:epetrich.AT.users.sourceforge.net">Erik
Petrich &lt;epetrich.AT.users.sourceforge.net&gt;</a>
- Bug fixes and improvements for the front end, 8051, z80 and hc08</li>
        <li><a href="mailto:dave.AT.kd0yu.com">Dave
Helton &lt;dave.AT.kd0yu.com&gt;</a>
- website design</li>
        <li><a href="mailto:paul.AT.pjrc.com">Paul
Stoffregen &lt;paul.AT.pjrc.com&gt;</a> - mcs51
optimizations and website maintenance.</li>
        <li><a href="mailto:michaelh.AT.juju.net.nz">Michael
Hope &lt;michaelh.AT.juju.net.nz&gt;</a> - initial Z80
port, additional coding and bug fixes.</li>
        <li><a href="mailto:sourceforge.brock.AT.dse.nl">Maarten
Brock &lt;sourceforge.brock.AT.dse.nl&gt;</a> - several
bug fixes and improvements, esp. for mcs51 port</li>
        <li><a href="mailto:RNeider.AT.web.de">Raphael
Neider &lt;RNeider.AT.web.de&gt;</a> - bug fixes and
optimizations for PIC16, completion of the PIC14 port</li>
      </ul>
      <p>SDCC has had help from a number of external sources,
including: </p>
      <ul>
        <li><a href="mailto:baldwin.AT.shop-pdp.kent.edu">Alan
Baldwin &lt;baldwin.AT.shop-pdp.kent.edu&gt;</a>
- Initial version of ASXXXX&nbsp; and&nbsp; ASLINK.</li>
        <li><a href="mailto:jhartman.AT.compuserve.com">John
Hartman &lt;jhartman.AT.compuserve.com&gt;</a>
- Porting ASXXX&nbsp;&nbsp; and ASLINK for 8051.</li>
        <li><a href="mailto:boehm.AT.sgi.com">Jans J
Boehm &lt;boehm.AT.sgi.com&gt;</a> and Alan J
Demers - Conservative garbage collector for C &amp; C++.</li>
        <li><a href="mailto:dso.AT.usa.net">Dmitry
S. Obukhov &lt;dso.AT.usa.net&gt;</a> - malloc and
serial I/O routines.</li>
        <li>Unknown - for the GNU C - preprocessor</li>
        <li><a href="mailto:malini_dutta.AT.hotmail.com">Malini
Dutta &lt;malini.AT.mediaone.net&gt;</a> -
Sandeep's wife, for her patience and support.</li>
      </ul>
      <h2>Past news</h2>
      <p><i><b>July 28th, 2006: SDCC 2.6.0 RC2 released.</b></i></p>
      <p>SDCC 2.6.0 Release Candidate 2 packages for x86 Linux, 32 bit Windows,
ppc MacOSX and doc packages are available at: <a href="http://sdcc.sourceforge.net/snapshots/sdcc-2.6.0-rc2">http://sdcc.sourceforge.net/snapshots/sdcc-2.6.0-rc1</a>
and <a href="http://sdcc.sourceforge.net/snap.php">http://sdcc.sourceforge.net/snap.php</a>.</p>
      <p><i><b>July 12th, 2006: SDCC 2.6.0 RC1 released.</b></i></p>
      <p>SDCC 2.6.0 Release Candidate 1 packages for x86 Linux, 32 bit Windows,
ppc MacOSX and doc packages are available at: <a href="http://sdcc.sourceforge.net/snapshots/sdcc-2.6.0-rc1">http://sdcc.sourceforge.net/snapshots/sdcc-2.6.0-rc1</a>
and <a href="http://sdcc.sourceforge.net/snap.php">http://sdcc.sourceforge.net/snap.php</a>.</p>
      <p><i><b>April 19th, 2006: SDCC migrated from CVS to Subversion version control system.</b></i></p>
      <p><a href="previous.php">Previous News</a></p>
<?php include('./footer.php')?>
      </td>
    </tr>
  </tbody>
</table>
</div>
</body>
</html>
