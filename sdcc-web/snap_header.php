<?php
/*-------------------------------------------------------------------------
   snap_head.php - snapshot builds page head

   Copyright (C) 2011, Borut Razem <borut.razem AT gmail.com>

   This library is free software; you can redistribute it and/or modify it
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

   As a special exception, if you link this library with other files,
   some of which are compiled with SDCC, to produce an executable,
   this library does not by itself cause the resulting executable to
   be covered by the GNU General Public License. This exception does
   not however invalidate any other reasons why the executable file
   might be covered by the GNU General Public License.
-------------------------------------------------------------------------*/

$regTestDb = new mysqli('mysql-s', 's599ro', 'riaPhiUp', 's599_regtests');

$query = 'SELECT DISTINCT `platform` FROM `regtest_results`';

$result = $regTestDb->query($query);

$platforms = array();
if ($result) {
  while ($row = $result->fetch_array(MYSQLI_NUM)) {
    $platforms[] = $row[0];
  }
  $result->free();
}
else {
  echo('DB Error: could not execute the database quey = ' . $query . "\n");
  echo('MySQL Error: ' . $regTestDb->error . "\n");
}
$regTestDb->close();
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
  <meta content="text/html; charset=UTF-8" http-equiv="content-type" />
  <title>SDCC - Snapshot Builds</title>
  <link type="text/css" href="style.css" rel="stylesheet" />
  <link rel="shortcut icon" type="image/x-icon" href="/images/sdcc.ico" />
  <!-- jQuery -->
  <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
  <!-- required plugins -->
  <script type="text/javascript" src="scripts/date.js"></script>
  <!-- jquery.datePicker.js -->
  <script type="text/javascript" src="scripts/jquery.datePicker.js"></script>
  <!-- datePicker required styles -->
  <link rel="stylesheet" type="text/css" media="screen" href="styles/datePicker.css"></link>
  <!-- page specific scripts -->
  <script type="text/javascript" charset="utf-8">
<!--
Date.format = 'yyyy-mm-dd';
$(function()
{
  $('.date-pick').datePicker(
    {
      startDate: '1970-01-01',
      endDate: (new Date()).asString()
    }
  );
});

function validateFormOnSubmit(theForm) {
  var build_date = false;
  var error = '';
  var build = theForm.build.value;
  var platform = theForm.platform.value;

  // validate the build date / number
  if (/^\d{4}-\d{2}-\d{2}$/.test(build)) {
    build_date = true;
  }
  else if (!/^\d+$/.test(build)) {
    alert("Bad build date or number!\n");
    return false;
  }

  // validate the platform
  var platforms = [ <?php echo('"' . implode('", "', $platforms) . '"'); ?> ];

  var is_platform = false;
  for (var i = 0; i < platforms.length; ++i) {
    if (platforms[i] == platform) {
      is_platform = true;
      break;
    }
  }

  if (!is_platform) {
    alert("Bad / unknown platform!\n");
    return false;
  }

  theForm.where.value = (build_date ? "`date` = '" : "`build_number` = '") + build + "' AND `platform` = '" + platform + "'";

  return true;
}
-->
  </script>
  <style type="text/css">
/* located in demo.css and creates a little calendar icon
 * instead of a text link for "Choose date"
 */
a.dp-choose-date {
  float: left;
  width: 22px;
  height: 22px;
  padding: 0;
  margin: 2px 3px 0;
  display: block;
  text-indent: -2000px;
  overflow: hidden;
  background: url(images/timespan.png) no-repeat; 
}
a.dp-choose-date.dp-disabled {
  background-position: 0 -20px;
  cursor: default;
}
/* makes the input field shorter once the date picker code
 * has run (to allow space for the calendar icon
 */
input.dp-applied {
  width: 140px;
  float: left;
}
  </style>
</head>
<body bgcolor="white" link="teal" vlink="#483d8b">
  <div align="left">
    <h1>SDCC - Snapshot Builds</h1>
    <table border="0" cellpadding="2" cellspacing="1" width="100%" bgcolor="white">
    <tbody>
      <tr>
        <td width="15%" valign="top"><?php echo(file_get_contents('./left_menu.inc'));?>
        </td>
        <td width="85%">
          <h2><a name="What"></a>Automatically Updated Snapshot Builds</h2>
          <p>
These snapshot builds are automatically updated from the developmental
code in the Subversion repository.  They are <i>not</i> official releases
and should be considered "beta" quality.  Some may not even work
at all if a serious bug was introduced during development, so
several are provided to give you the best chance of finding one
that will work.
          </p>
          <p>
Because official SDCC releases are infrequent, these snapshot builds
often contain fixes for bugs discovered in the last official
release. If you do encounter a bug, please test the latest
snapshot build to see if it has already been fixed by a developer.
          </p>
          <p>
To see what developers have added, you can
<a href="https://sdcc.svn.sourceforge.net/svnroot/sdcc/trunk/sdcc/ChangeLog">
view the ChangeLog</a> directly from the Subversion repository.
          </p>
          <p>
Download full <a href="http://sdcc.sourceforge.net/download_regtests_db.php">regression test results database</a> in CSV format.
          </p>
          <form name="regtest" onsubmit="return validateFormOnSubmit(this)" action="download_regtests_db.php" method="post">
            Download regression test results in CSV format for<br />
            <table>
              <tr>
                <td><label for="build">Build date (YYYY-MM-DD) or build number:</label></td>
                <td><input name="build" id="build" class="date-pick" /></td>
              </tr>
              <tr>
                <td>Platform:</td>
                <td>
                  <select name="platform">
<?php
  foreach ($platforms as $platform) {
    echo('                    <option value="' . $platform . '">' . $platform . "</option>\n");
  }
?>
                  </select>
                </td>
              </tr>
            </table>
            <input type="hidden" name="where" />
            <input type="submit" />
          </form>
