#! /usr/bin/perl

use Getopt::Std;

# main procedure

{
  getopts('s:');

  my $section_name = defined($opt_s) ? $opt_s : "SDCC Docs";

  my $body_stuff = "bgcolor=\"white\" link=\"teal\" vlink=\"#483d8b\"";
  my $font_begin = "<font face=\"Arial,Helvetica,Geneva,Swiss,SunSans-Regular\">";
  my $font_end = "</font>";
  my $header_begin = "<table border=\"0\" cellpadding=\"0\" cellspacing=\"1\" width=\"100%\" bgcolor=\"#5f9ea0\"><tr><td>";
  my $header_end = "</td></tr></table>";
  my $favicon = "<link rel=\"shortcut icon\" type=\"image/x-icon\" href=\"/images/sdcc.ico\" />\n";

  my $at_body_begin = 0;
  my $seen_header = 0;
  my $subsections = undef;

  while (<>) {
    # add favicon at the end of head
    if (/^<\/HEAD>/) {
      print($favicon . $_);
      next;
    }

    # treak the title, so google results and bookmarks show SDCC as first word
    if (/^<TITLE>/) {
      my $t = $_;
      while ($t !~ /<\/TITLE>/) {
        $t =~ s/\s+$//;
        $t .= ' ';
        $t .= <>;
      }
      $t =~ /<TITLE>([^<>]+)<\/TITLE>/;
      my $orig_title = $1;
      my $title = $section_name . ': ' . $orig_title;
      print "<TITLE>$title</TITLE>$'\n";
      next;
    }

    # add the top title, body colors and left side nav bar
    if (/^<BODY\s*>/) {
      print "<BODY $body_stuff>$'\n";
      print "<div align=\"left\">\n";
      print "<h2>$font_begin<i>$title</i>$font_end</h2>\n";
      print "<p>\n";
      print "<table border=\"0\" cellpadding=\"2\" cellspacing=\"1\" width=\"100%\" bgcolor=\"white\">\n";
      print "<tbody>\n";
      print "<tr>\n";
      print "<td width=\"15%\" valign=\"top\">\n";
      print "<?php echo(file_get_contents('../../left_menu.inc'));?>\n";
      print "</td>\n";
      print "<td width=\"85%\" valign=\"top\">\n";
      print "$font_begin\n";
      $at_body_begin = 1;
      next;
    }

    # complete the div and table opened by the nav bar
    if (/^<\/BODY>/) {
      print "$font_end\n";
      print "</table>\n";
      print "</div>\n";
      print;
      next;
    }

    # remove the latex2html nav at top of the page
    if (/^<!--Navigation Panel-->/ && $at_body_begin) {
      my $nav = '';
      my $nav_buttons = 1;
      while (<>) {
        $nav_buttons = 0 if /<BR>/;
        $nav .= $_ if $nav_buttons;
        last if /<!--End of Navigation Panel-->/;
      }
      if ($nav) {
        print "<table align=right width=70>";
        print "<tr><td><b><u>$section_name</tr></td>\n";
        print "<tr><td>";
        print $nav;
        print "</td></tr>\n";
        print "<tr height=800><td>&nbsp;</td></tr>\n";
        print "</table>\n";
      }
      next;
    }

    # find headers and massage them a bit
    if (/^<H[1-6]>/) {
      print $header_begin;
      print;
      while (<>) {
        next if /^<BR>\s*$/;  #omit excessive blank lines
        print;
        last if /^<\/H[1-6]>/;
      }
      print $header_end;
      if ($subsections) {
        print $subsections;
        undef $subsections;
      }
      $seen_header = 1;
    }

    # remove subsections html (will put back in later)
    if (/^<!--Table of Child-Links-->/ && ! $seen_header) {
      $subsections = $_;
      while (<>) {
        $subsections .= $_;
        last if /<!--End of Table of Child-Links-->/;
      }
      $_ = <>;
      last unless $_;
      next if /^<HR>/;
    }

    # if we find a hr and have stored subsections, better print em!
    if (/<HR>/) {
      print $subsections;
      undef $subsections;
    }

    print;
    $at_body_begin = 0;
  }
}
