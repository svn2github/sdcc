<?php
/*-------------------------------------------------------------------------
   snap.php - snapshot builds page

   Copyright (C) 2011, Borut Razem <borut.razem AT gmail.com>

   This program is free software; you can redistribute it and/or modify it
   under the terms of the GNU General Public License as published by the
   Free Software Foundation; either version 2.1, or (at your option) any
   later version.

   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License 
   along with this library; see the file COPYING. If not, write to the
   Free Software Foundation, 51 Franklin Street, Fifth Floor, Boston,
   MA 02110-1301, USA.
-------------------------------------------------------------------------*/

class LsDir {
  protected $curdir;
  protected $root;


  public function dump()
  {
    print_r($this);
  }


  public function __construct()
  {
    $this->root = array("files" => array(), "name" => "/");
    $this->curdir = &$this->root;
  }


  public function chDir($path, $relative = false)
  {
    if ($relative) {
      $cur = &$this->curdir;
    }
    else {
      $cur = &$this->root;
    }

    $cur = &$this->travel($cur, $path);

    if ($cur != null) {
      $this->curdir = &$cur;
      return true;
    }
    else {
      return false;
    }
  }


  public function mkDir($path, $relative = false)
  {
    if ($relative) {
      $cur = &$this->curdir;
    }
    else {
      $cur = &$this->root;
    }

    $this->travel($cur, $path, true);
  }


  protected function _exists($dir, $path)
  {
    return array_key_exists($path, $dir["files"]);
  }


  public function exists($path)
  {
    return $this->_exists($this->curdir, $path);
  }


  protected function _isDir($dir, $path)
  {
    return $this->_exists($dir, $path) && array_key_exists("files", $dir["files"][$path]);
  }


  public function isDir($path)
  {
    return $this->_isDir($this->curdir, $path);
  }


  protected function _pwd(&$res, &$dir)
  {
    foreach (array_keys($dir["files"]) as $file) {
      if ($this->_isDir($dir, $file)) {
        if ($this->_pwd($res1, $dir["files"][$file]))
          $res .= $file . "/" . $res1;
          return true;
      }
      else {
        return false;
      }
    }
  }


  public function pwd()
  {
    if ($this->_pwd($res, $this->root)) {
      return "/" . $res;
    }
    else {
      return null;
    }
  }


  public function add($path, $attr)
  {
    if ($this->exists($path)) {
      return false;
    }
    $this->curdir["files"][$path] = $attr;
  }


  public function getAttr($path)
  {
    if (!$this->exists($path)) {
      return null;
    }
    return $this->curdir["files"][$path];
  }


  public function entries()
  {
    return array_keys($this->curdir["files"]);
  }


  protected function &travel(&$cur, $path, $create = false)
  {
    if (!is_array($path)) {
      if ($path == "") {
        return $cur;
      }
      $path = preg_split("/\/+/", preg_replace("|^/*(.*)/*$|", "$1", $path));
    }

    foreach($path as $file) {
      if (!$this->_exists($cur, $file)) {
        if ($create) {
          $cur["files"][$file] = array("files" => array(), "name" => $file);
        }
        else {
          return false;
        }
      }
      if ($this->_isDir($cur, $file)) {
        $cur = &$cur["files"][$file];
      }
      else {
        return false;
      }
    }
    return $cur;
  }
}


function green_bar($text, $name)
{
  echo "<h2><a name=\"" . $name . "\"></a>" . $text . "</h2>\n";
}

function file_name_to_snapshot_id($fname)
{
  $ret = preg_replace('/sdcc-snapshot-([^-]+-[^-]+-[^ ]+-\d{8}-\d+)\..*/', '$1', $fname);
  if ($ret === $fname) {
    $ret = preg_replace('/sdcc-snapshot-([^-]+-[^ ]+-\d{8}-\d+)\..*/', '$1', $fname);
    if ($ret === $fname)
      $ret = preg_replace('/.*-([^-]+-[^-]+-[^ ]+-\d{8}-\d+)\..*/', '$1', $fname);
  }

  return $ret;
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
      if (($failures && $failures > 0) || preg_match('/Error/', $line) || preg_match('/invalid instructions/', $line))
        return true;
    }
  
    return false;
  }
  else
    return null;
}

function display_files($descdir, $lsDir, $cldir, $rtdir, $subdir)
{
  $numfiles = 0;
  $lsDir->chDir($subdir);

  foreach ($lsDir->entries() as $file) {
    if ($file != "HEADER.html" && $file != ".htaccess") { 
      $attr = $lsDir->getAttr($file);
      $file_name[$numfiles] = $file;
      $file_size[$numfiles] = $attr["size"];
      $file_date[$numfiles] = $attr["date"];
      $numfiles++;
    }
  }
  # dates are in text format, so the sort is not working as expected
  # files seems to be already sorted by the date in tree.txe, so additional sorting is not needed!
  #if ($numfiles > 0) {
  #  array_multisort($file_date, SORT_DESC, $file_name, $file_size);
  #}

  echo "<p><img src=\"/images/folder-B4-6-32x32.png\" border=\"0\" align=\"bottom\" alt=\"Folder\" />";
  echo "<font face=\"Arial,Helvetica,Geneva,Swiss,SunSans-Regular\"><b><i>";
  if (is_file($descdir. "/" . $subdir . ".desc")) {
    include $descdir. "/" . $subdir . ".desc";
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

  # set the default timezone to use. Available since PHP 5.1
  date_default_timezone_set("UTC");

  for ($i = 0; $i < $numfiles; ++$i) {
    $fs = round($file_size[$i] / 1024, 0);
    $subdirpp = preg_replace("/\s/","%20","$subdir");
    $filep = preg_replace("/\s/","%20",$file_name[$i]);
    #$modDate = date("M j H:i T", $file_date[$i]);
    $modDate = $file_date[$i];

    # ChangeLog head
    $cl = '&nbsp;';
    if ($cldir) {
      $clpath = $cldir . '/changelog-head-' . file_name_to_revision($file_name[$i]) . '.txt';
      if (is_file($clpath)) {
        $clpathp = preg_replace("/\s/", "%20", $clpath);
        $clIcon = '18dot5a.gif';
        $cl = "<a href=\"$clpathp\"><img src=\"/images/$clIcon\" border=\"0\" alt=\"ChangeLog Head\" /></a>";
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
        $rt = "<a href=\"$rtpathp\"><img src=\"/images/$rtIcon\" border=\"0\" alt=\"Regression Test Log\" /></a>";
      }
    }

    $dispthisdir = "<tr>" .
      "<td align=\"left\"><a href=\"http://sourceforge.net/projects/sdcc/files/snapshot_builds/$subdirpp/$filep/download\">$file_name[$i]</a></td>" .
      "<td align=\"left\">$fs K</td>" .
      "<td align=\"left\">$modDate</td>" .
      "<td align=\"left\">$cl</td>" .
      "<td align=\"left\">$rt</td>".
      "</tr>";

    echo $dispthisdir;
  }
  echo "</table></div>\n";
}


function line2stat($line)
{
  $res = preg_split("/\s+/", $line, 9);
  $path = explode('/', $res[8], 2);
  if ($path[1] != "") {
    $path[0] = $path[1] . '/' . $path[0];
  }
  return array($path[0], substr($res[0], 0, 1), array("size" => $res[4], "date" => $res[5] . " " . $res[6] . " " . $res[7]));
}


function &tree_array($file)
{
  $lsDir = new LsDir();

  foreach (file($file) as $line) {
    $stat = line2stat(rtrim($line));
    $type = $stat[1];
    $file = $stat[0];
    if ($type == "d") {
      if (!$lsDir->isDir($file)) {
        $lsDir->mkDir($file);
      }
      $lsDir->chDir($file);
    }
    else {
      $lsDir->add($file, $stat[2]);
    }
  }

  return $lsDir;
}


function parse_dir($descdir, $scanthis, $cldir, $rtdir)
{
  $linux_num = $windows_num = $windows64_num = $macosx_num = $docs_num = $other_docs_num = $source_num = $other_num = 0;

  $lsDir = tree_array($scanthis);
  $lsDir->chDir("");

  foreach ($lsDir->entries() as $file) {
    if ($lsDir->isDir($file)) {
      if (preg_match('/(i386|amd64)-.*-linux/', $file)) {
        $linux_dir[$linux_num++] = $file;
      }
      elseif (preg_match('/msvc/', $file)) {
        $windows_dir[$windows_num++] = $file;
      }
      elseif (preg_match('/x86_64-w64/', $file)) {
        $windows64_dir[$windows64_num++] = $file;
      }
      elseif (preg_match('/macosx/', $file)) {
        $macosx_dir[$macosx_num++] = $file;
      }
      elseif (preg_match('/docs$/', $file)) {
        $docs_dir[$docs_num++] = $file;
      }
      elseif (preg_match('/docs_/', $file)) {
        $other_docs_dir[$other_docs_num++] = $file;
      }
      elseif (preg_match('/-src/', $file)) {
        $source_dir[$source_num++] = $file;
      }
      else {
        $other_dir[$other_num++] = $file;
      }
    }//end-if
  }//end-while

  green_bar("Supported Linux Binaries", "Linux");
  for ($i = 0; $i < $linux_num; $i++) {
    display_files($descdir, $lsDir, $cldir, $rtdir, $linux_dir[$i]);
  }

  green_bar("Supported Windows - x86 Binaries", "Windows32");
  for ($i = 0; $i < $windows_num; $i++) {
    display_files($descdir, $lsDir, $cldir, $rtdir, $windows_dir[$i]);
  }

  green_bar("Supported Windows - x86_64 Binaries", "Windows64");
  for ($i = 0; $i < $windows64_num; $i++) {
    display_files($descdir, $lsDir, $cldir, $rtdir, $windows64_dir[$i]);
  }

  green_bar("Supported Mac OS X Binaries", "MacOSX");
  for ($i = 0; $i < $macosx_num; $i++) {
    display_files($descdir, $lsDir, $cldir, $rtdir, $macosx_dir[$i]);
  }

  green_bar("Documentation", "Docs");
  for ($i = 0; $i < $docs_num; $i++) {
    display_files($descdir, $lsDir, $cldir, false, $docs_dir[$i]);
  }
  for ($i = 0; $i < $other_docs_num; $i++) {
    display_files($descdir, $lsDir, false, false, $other_docs_dir[$i]);
  }

  green_bar("Source Code", "Source");
  for ($i = 0; $i < $source_num; $i++) {
    display_files($descdir, $lsDir, $cldir, false, $source_dir[$i]);
  }

  if ($other_num > 0) green_bar("Other Files", "Other");
  for ($i = 0; $i < $other_num; $i++) {
    display_files($descdir, $lsDir, $cldir, $rtdir, $other_dir[$i]);
  }
}//end-function declaration

require 'snap_header.php';

parse_dir('snapshots.desc', 'tree.txt', 'changelog_heads', 'regression_test_results');

require 'snap_footer.php';
?>
