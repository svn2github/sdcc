<?php

require 'snap_header.php';

parse_dir("snapshots", "changelog_heads", "regression_test_results");

require 'snap_footer.php';


function green_bar($text, $name)
{
  echo "<h2><a name=\"" . $name . "\"></a>" . $text . "</h2>\n";
}

function file_name_to_snapshot_id($fname)
{
  return preg_replace('/.*-([^-]+-[^-]+-[^-]+-\d{8}-\d+)\..*/', '$1', $fname);
}

function file_name_to_revision($fname)
{
  return preg_replace('/.*-\d{8}-(\d+).*/', '$1', $fname);
}

function rt_failed($fname)
{
  if ($handle = fopen($fname, "r")) {
    while ($line = fgets($handle)) {
      # Summary for 'host': 0 failures, 4244 tests, 596 test cases, 0 bytes, 0 ticks
      $failures = preg_replace('/^Summary for \'.+\':.* (\d+) failures, \d+ tests, \d+ test cases, \d+ bytes, \d+ ticks/',
        '$1', $line);
      if ($failures && $failures > 0)
        return true;
    }
  
    return false;
  }
  else
    return null;
}

function display_files($dir, $cldir, $rtdir, $subdir)
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

  echo "<p><img src=\"/images/dir.gif\" border=\"0\" align=\"bottom\" width=\"20\" height=\"22\" alt=\"Directory\" />";
  echo "<font face=\"Arial,Helvetica,Geneva,Swiss,SunSans-Regular\"><b><i>";
  if (is_file("$dir/../snapshots.desc/$subdir.desc")) {
    include "$dir/../snapshots.desc/$subdir.desc";
  }
  echo "($subdir)</i></b></font></p>\n";
  echo "<div style=\"padding-left: 2em\">\n";
  echo "<table width=\"100%\" border=\"0\" cellpadding=\"2\" cellspacing=\"1\"><tr>";
  echo "<th align=\"left\"><font color=\"#660000\" face=\"Arial,Helvetica,Geneva,Swiss,SunSans-Regular\">Filename</font></th>";
  echo "<th align=\"left\"><font color=\"#660000\" face=\"Arial,Helvetica,Geneva,Swiss,SunSans-Regular\">Size</font></th>";
  echo "<th align=\"left\"><font color=\"#660000\" face=\"Arial,Helvetica,Geneva,Swiss,SunSans-Regular\">Snapshot Date</font></th>";
  if ($cldir)
    echo "<th align=\"left\"><font color=\"#660000\" face=\"Arial,Helvetica,Geneva,Swiss,SunSans-Regular\">CL</font></th>";
  if ($rtdir)
    echo "<th align=\"left\"><font color=\"#660000\" face=\"Arial,Helvetica,Geneva,Swiss,SunSans-Regular\">RT</font></th>";
  echo "</tr>\n";

  for ($i=0; $i<$numfiles; $i++) {
    $fs = round($file_size[$i] / 1024,0);
    $subdirpp = preg_replace("/\s/","%20","$dir/$subdir");
    $filep = preg_replace("/\s/","%20",$file_name[$i]);
    $modDate = date("F j, Y", $file_date[$i]);

    # ChangeLog head
    $cl = '&nbsp;';
    if ($cldir) {
      $clpath = $cldir . '/changelog-head-' . file_name_to_revision($file_name[$i]) . '.txt';
      if (is_file($clpath)) {
        $clpathp = preg_replace("/\s/", "%20", $clpath);
        $clIcon = '18dot2a.gif';
        $cl = "<a href=\"$clpathp\"><img src=\"/images/$clIcon\" border=\"0\" alt=\"RT\" /></a>";
      }
    }

    # Regression test
    $rt = '&nbsp;';
    if ($rtdir) {
      $rtpath = $rtdir . '/' . $subdir . '/regression-test-' . file_name_to_snapshot_id($file_name[$i]) . '.log';
      if (is_file($rtpath)) {
        $rtpathp = preg_replace("/\s/", "%20", $rtpath);
        $failed = rt_failed($rtpathp);
        if (isset($failed))
          $rtIcon = $failed ? '18dot1a.gif' : '18dot4a.gif';
        else
          $rtIcon = '18dot2a.gif';
        $rt = "<a href=\"$rtpathp\"><img src=\"/images/$rtIcon\" border=\"0\" alt=\"RT\" /></a>";
      }
    }

    $dispthisdir = "<tr>" .
      "<td align=\"left\"><a href=\"$subdirpp/$filep\">$file_name[$i]</a></td>" .
      "<td align=\"left\">$fs K</td>" .
      "<td align=\"left\">$modDate</td>" .
      "<td align=\"left\">$cl</td>" .
      "<td align=\"left\">$rt</td>".
      "</tr>";

    echo $dispthisdir;
  }
  echo "</table></div>\n";
}


function parse_dir($scanthis, $cldir, $rtdir)
{
  $linux_num = $windows_num = $docs_num = $other_docs_num = $source_num = $other_num = 0;

  $dir = @opendir($scanthis);
  while (false!=($file = @readdir($dir))) {
    if (is_dir($scanthis."/".$file) && $file != "." && $file != "..") {
      if (preg_match('/linux/', $file)) {
        $linux_dir[$linux_num++] = $file;
      } elseif (preg_match('/msvc/', $file)) {
        $windows_dir[$windows_num++] = $file;
      } elseif (preg_match('/docs$/', $file)) {
        $docs_dir[$docs_num++] = $file;
      } elseif (preg_match('/docs_/', $file)) {
        $other_docs_dir[$other_docs_num++] = $file;
      } elseif (preg_match('/-src/', $file)) {
        $source_dir[$source_num++] = $file;
      } else {
        $other_dir[$other_num++] = $file;
      }
    }//end-if
  }//end-while

  green_bar("Linux Binaries", "Linux");
  for ($i=0; $i<$linux_num; $i++) {
    display_files($scanthis, $cldir, $rtdir, $linux_dir[$i]);
  }
  green_bar("Windows Binaries", "Windows");
  for ($i=0; $i<$windows_num; $i++) {
    display_files($scanthis, $cldir, false, $windows_dir[$i]);
  }
  green_bar("Documentation", "Docs");
  for ($i=0; $i<$docs_num; $i++) {
    display_files($scanthis, $cldir, false, $docs_dir[$i]);
  }
  for ($i = 0; $i < $other_docs_num; $i++) {
    display_files($scanthis, false, false, $other_docs_dir[$i]);
  }
  green_bar("Source Code", "Source");
  for ($i=0; $i<$source_num; $i++) {
    display_files($scanthis, $cldir, false, $source_dir[$i]);
  }
  if ($other_num > 0) green_bar("Other Files", "Other");
  for ($i=0; $i<$other_num; $i++) {
    display_files($scanthis, $cldir, $rtdir, $other_dir[$i]);
  }

}//end-function declaration

?>
