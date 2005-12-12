<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
  <meta content="text/html; charset=UTF-8" http-equiv="content-type">
  <title>SDCC Previous News and Changes</title>
  <link rel="stylesheet" href="style.css" type="text/css">
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
      <p> </p>
      <hr width="60%">
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
