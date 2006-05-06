#! /usr/bin/perl

use Getopt::Std;

getopts('f:');

$section_name = $ENV{'SDCC_SECTION'} if $ENV{'SDCC_SECTION'};
$section_name = "SDCC Docs" unless $section_name;	# default name


$body_stuff = "bgcolor=\"white\" link=\"teal\" vlink=\"#483d8b\"";
$navbar_file = defined($opt_f) ? $opt_f : "sdcc_theme_navbar.html";
$font_begin = "<font face=\"Arial,Helvetica,Geneva,Swiss,SunSans-Regular\">";
$font_end = "</font>";
$header_begin = "<table border=\"0\" cellpadding=\"0\" cellspacing=\"1\" width=\"100%\" bgcolor=\"#5f9ea0\"><tr><td>";
$header_end = "</td></tr></table>";

while (<>) {
	# treak the title, so google results and bookmarks show SDCC as first word
	if (/^<TITLE>/) {
		$t = $_;
		while ($t !~ /<\/TITLE>/) {
			$t =~ s/\s+$//;
			$t .= ' ';
			$t .= <>;
		}
		$t =~ /<TITLE>([^<>]+)<\/TITLE>/;
		$orig_title = $1;
		$title = $section_name . ': ' . $orig_title;
		print "<TITLE>$title</TITLE>$'\n";
		next;
	}
	# add the top title, body colors and left side nav bar
	if (/^<BODY\s*>/) {
		print "<BODY $body_stuff>$'\n";
		print "<div align=\"left\">\n";
		print "<h2>$font_begin<i>$title</i>$font_end</h2>\n";
		print `cat $navbar_file`;
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
		undef $nav;
		$nav_buttons = 1;
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
			next if /^<BR>\s*$/;	#omit excessive blank lines
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
