<?php

require 'snap_header.html';

parse_dir("snapshots");

require 'snap_footer.html';



function green_bar($text, $name)
{
	echo "\t<table border=\"0\" cellpadding=\"0\" cellspacing=\"1\" width=\"100%\" bgcolor=\"#5f9ea0\"><tr>\n";
	echo "\t<td><font face=\"Arial,Helvetica,Geneva,Swiss,SunSans-Regular\"><i><b>";
	echo "<a name=\"" . $name . "\"></a>" . $text . "</b></i></font></td>\n";
	echo "\t</tr></table>\n";
}

function display_files($dir, $subdir)
{
	$numfiles = 0;
	$thissubdir = @opendir("$dir/$subdir");
	while (false!=($file = @readdir($thissubdir))) {
		if ($file != "." && $file != ".." && $file != "HEADER.html" && $file != ".htaccess") { 
			$file_name[$numfiles] = $file;
			$file_size[$numfiles] = filesize("$dir/$subdir/$file");
			$file_date[$numfiles] = filemtime("$dir/$subdir/$file");
			$numfiles++;
		}
	}
	if ($numfiles > 0) {
		array_multisort($file_date, SORT_DESC, $file_name, $file_size);
	}

	echo "<p><img src=\"/images/dir.gif\" border=\"0\" align=bottom width=20 height=22 alt=\"Directory\">";
	echo "<font face=\"Arial,Helvetica,Geneva,Swiss,SunSans-Regular\"><b><i>";
	if (is_file("$dir/../snapshots.desc/$subdir.desc")) {
		include "$dir/../snapshots.desc/$subdir.desc";
	}
	echo "($subdir)</i></b></font>\n";
	echo "<div style=\"padding-left: 2em\">\n";
	echo "<table width=\"100%\" border=\"0\" cellpadding=\"2\" cellspacing=\"1\"><tr>";
	echo "<th align=\"left\"><font color=\"#660000\" face=\"Arial,Helvetica,Geneva,Swiss,SunSans-Regular\">Filename</font></th>";
	echo "<th align=\"left\"><font color=\"#660000\" face=\"Arial,Helvetica,Geneva,Swiss,SunSans-Regular\">Size</font></th>";
	echo "<th align=\"left\"><font color=\"#660000\" face=\"Arial,Helvetica,Geneva,Swiss,SunSans-Regular\">Snapshot Date</font></th>";
	echo "</tr>\n";
	for ($i=0; $i<$numfiles; $i++) {
		$fs = round($file_size[$i] / 1024,0);
		$subdirpp = preg_replace("/\s/","%20","$dir/$subdir");
		$filep = preg_replace("/\s/","%20",$file_name[$i]);
		$modDate = date("F j, Y", $file_date[$i]);
		$dispthisdir = "<tr><td align=\"left\">
			<a href=\"$subdirpp/$filep\">$file_name[$i]</a></td><td align=\"left\">
			$fs K</td><td align=\"left\">
			$modDate</td></tr>";
		echo $dispthisdir;
	}
	echo "</table></div>\n<p>\n";
}


function parse_dir($scanthis)
{
	$linux_num = $windows_num = $docs_num = $source_num = $other_num = 0;

	$dir = @opendir($scanthis);
	while (false!=($file = @readdir($dir))) {
		if (is_dir($scanthis."/".$file) && $file != "." && $file != "..") {
			if (preg_match('/linux/', $file)) {
				$linux_dir[$linux_num++] = $file;
			} elseif (preg_match('/msvc/', $file)) {
				$windows_dir[$windows_num++] = $file;
                        } elseif (preg_match('/docs/', $file)) {
                                $docs_dir[$docs_num++] = $file;
			} elseif (preg_match('/-src/', $file)) {
				$source_dir[$source_num++] = $file;
			} else {
				$other_dir[$other_num++] = $file;
			}
		}//end-if
	}//end-while

	green_bar("Linux Binaries", "Linux");
	for ($i=0; $i<$linux_num; $i++) {
		display_files($scanthis, $linux_dir[$i]);
	}
	green_bar("Windows Binaries", "Windows");
	for ($i=0; $i<$windows_num; $i++) {
		display_files($scanthis, $windows_dir[$i]);
	}
        green_bar("Documentation", "Docs");
        for ($i=0; $i<$docs_num; $i++) {
                display_files($scanthis, $docs_dir[$i]);
        }
	green_bar("Source Code", "Source");
	for ($i=0; $i<$source_num; $i++) {
		display_files($scanthis, $source_dir[$i]);
	}
	if ($other_num > 0) green_bar("Other Files", "Other");
	for ($i=0; $i<$other_num; $i++) {
		display_files($scanthis, $other_dir[$i]);
	}

}//end-function declaration


?>
