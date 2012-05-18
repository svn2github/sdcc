<?php
/*-------------------------------------------------------------------------
   regtests.php - regression tests page

   Copyright (C) 2011, 2012, Borut Razem <borut.razem AT gmail.com>

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

$ini = parse_ini_file('sdcc.ini');
$regTestDb = new mysqli($ini['host'], $ini['username'], $ini['passwd'], $ini['dbname']);

$query = 'SELECT DISTINCT `platform` FROM `regtest_results`';

$result = $regTestDb->query($query);

$platforms = array();
if ($result) {
  while ($row = $result->fetch_array(MYSQLI_NUM)) {
    $platforms[] = $row[0];
  }
  $result->free();
}

$query = 'SELECT DISTINCT `target` FROM `regtest_results`';

$result = $regTestDb->query($query);

$targets = array();
if ($result) {
  while ($row = $result->fetch_array(MYSQLI_NUM)) {
    $targets[] = $row[0];
  }
  $result->free();
}

$regTestDb->close();

function genForm($id, $platforms, $targets)
{
  echo('          <form action="" class="diff" id="' . $id . "\" method=\"post\">\n");
  echo <<<EOT
            <table>
              <tr>
                <td align="right"><label for="date">Build date:</label></td>
                <td><input name="date" id="{$id}_date" class="date-pick" /></td>
              </tr>
              <tr>
                <td align="right">Build number:</td>
                <td>
                  <select name="build">
                    <option></option>
                  </select>
                </td>
              </tr>
              <tr>
                <td align="right">Platform:</td>
                <td>
                  <select name="platform">
EOT;

  foreach ($platforms as $platform) {
    echo('                    <option value="' . $platform . '">' . $platform . "</option>\n");
  }

 echo <<<EOT
                  </select>
                </td>
              </tr>
              <tr>
                <td align="right">Target:</td>
                <td>
                  <select name="target">
EOT;

  foreach ($targets as $target) {
    echo('                    <option value="' . $target . '">' . $target . "</option>\n");
  }

  echo <<<EOT
                  </select>
                </td>
              </tr>
            </table>
<!--            <button class="button positive"> <img src="../images/icons/tick.png" alt=""> Add Client </button> -->
          </form>
EOT;
}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
  <meta content="text/html; charset=UTF-8" http-equiv="content-type" />
  <title>SDCC - Regression Tests</title>
  <link type="text/css" href="styles/style.css" rel="stylesheet" />
  <link rel="shortcut icon" type="image/x-icon" href="/images/sdcc.ico" />
  <!-- jQuery -->
  <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
  <!-- required plugins -->
  <script type="text/javascript" src="scripts/date.js"></script>
  <!-- jquery.datePicker.js -->
  <script type="text/javascript" src="scripts/jquery.datePicker.js"></script>
  <!-- datePicker required styles -->
  <link rel="stylesheet" type="text/css" media="screen" href="styles/datePicker.css"></link>
  <!-- jquery.tablesorter.js -->
  <script type="text/javascript" src="scripts/jquery.tablesorter.js"></script> 
  <!-- tablesorter required styles -->
  <link rel="stylesheet" type="text/css" media="screen" href="styles/tablesorter.css"></link>
  <!-- page specific scripts -->
  <script type="text/javascript" charset="utf-8">
//<!--
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

function validateBuildDate(date)
{
  // validate the build date
  if (!/^\d{4}-\d{2}-\d{2}$/.test(date)) {
    alert("Bad build date!\n");
    return false;
  }
  return true;
}

function validateBuildNumber(build)
{
  // validate the build number
  if (!/^\d+$/.test(build)) {
    alert("Bad build number!\n");
    return false;
  }
  return true;
}

function validateTarget(target)
{
  // validate the target
  var targets = [ <?php echo('"' . implode('", "', $targets) . '"'); ?> ];

  var is_target = false;
  for (var i = 0; i < targets.length; ++i) {
    if (targets[i] == target) {
      is_target = true;
      break;
    }
  }
  if (!is_target) {
    alert("Bad / unknown target!\n");
    return false;
  }
  return true;
}

function validateFormOnSubmit(theForm)
{
  var date = theForm.date.value;
  var build = theForm.build.value;
  var platform = theForm.platform.value;

  if (validateBuildDate(date) && validateBuildNumber(build)) {
    // validate the platform
    var platforms = [ <?php echo('"' . implode('", "', $platforms) . '"'); ?> ];
  
    var is_platform = false;
    for (var i = 0; i < platforms.length; ++i) {
      if (platforms[i] == platform) {
        is_platform = true;
        break;
      }
    }

    return {
      date: date,
      build_number: build,
      platform: platform
    };
  }
  else
    return false;
}

function validateFormOnSubmitTarget(theForm)
{
  var target = theForm.target.value;

  ret = validateFormOnSubmit(theForm);

  if (ret && validateTarget(target)) {
    ret['target'] = target;
    return ret;
  }
  else {
    return false;
  }
}

function keyArray(obj) {
  var rv = [];
  $.each(obj, function(key)
  {
    rv.push(key);
  });
  return rv;
}

function genHiddenWhere(theForm)
{
  var val = validateFormOnSubmit(theForm);
  var where = '';
  var whereFirst = true;
  $.each(val, function(key)
  {
    if (!whereFirst) {
      where += 'AND ';
    }
    else {
      whereFirst = false;
    }
    where += '`' + key + "` = '" + val[key] + "' ";
  });

  theForm.where.value = where;

  return true
}

/*
// http://www.webtoolkit.info/scrollable-html-table-plugin-for-jquery.html
jQuery.fn.Scrollable = function(tableHeight, tableWidth) {
  this.each(function(){
    if (jQuery.browser.msie || jQuery.browser.mozilla) {
      var table = new ScrollableTable(this, tableHeight, tableWidth);
    }
  });
}
*/

function htmlTable (data)
{
  var ret = '';
  if (data) {
    ret += '<table id="dataTable" class="tablesorter"><thead><tr>'; 
    var keys = keyArray(data[0]);
    for (var i = 0; i < keys.length; ++i) {
      ret += '<th>' + keys[i] + '</th>';
    }
    ret += '</tr></thead>';
    ret += '<tbody>';
    for (var i = 0; i < data.length; ++i) {
      ret += '<tr>';
      $.each(data[i], function(key)
      {
        ret += '<td>' + data[i][key] + '</td>';
      });
      ret += '</tr>';
    }
    ret += '<tbody>';
    ret += '</table>';
  }
  return ret;
}

function composeQuery(data)
{
  var fields = [ 'failures', 'tests', 'cases', 'bytes', 'ticks' ];

  var select = 'SELECT `t0`.`regtest_name`, ';
  var from = ' FROM `regtest_results` AS t0 ';
  var on = 'ON ';
  var where = 'WHERE ';

  var first = true;
  var whereFirst = true;
  for (var i = 0; i < data.length; ++i) {
    for (var j = 0; j < fields.length; ++j) {
      if (!first) {
        select += ', ';
      }
      else {
        first = false;
      }
      select += '`t' + i + '`.`' + fields[j] + '` AS `' + fields[j] + i + '`'
    }
    if (i > 0) {
      from += 'JOIN `regtest_results` AS t' + i + ' ';
      if (i > 1) {
        on += 'AND ';
      }
      on += '`t' + i + '`.`regtest_name` = `t0`.`regtest_name` ';
    }

    $.each(data[i], function(key)
    {
      if (!whereFirst) {
        where += 'AND ';
      }
      else {
        whereFirst = false;
      }
      where += '`t' + i + '`.`' + key + "` = '" + data[i][key] + "' ";
    });
  }
  query = select + from + on + where;

  return query;
}

function buttonClick()
{
  $('body').css('cursor', 'wait')

  var params = [];
  $('form.diff').each(function()
  {
    params.push(validateFormOnSubmitTarget(this));
  });

  var query = composeQuery(params);

  if (query) {
    $.ajax({
      type: 'POST',
      url: 'get_regtest.php',
      dataType: 'json',
      data: { query: query },
      success: function(data) {
        $('div.success').replaceWith('<div class="success">' + ((data.length > 0) ? htmlTable(data) : 'No data available!') + '</div>');
        $('body').css('cursor','auto');
        $("#dataTable").tablesorter({
         // striping looking
         widgets: ['zebra']	
        }); 
      }
    });
  }
  return false;
}

/*
$(document).ready(function()
{
  jQuery('table').Scrollable(200, 800);
});
*/

$(function() {
  $("input.date-pick").change(function() {
    if (this.value != '' && validateBuildDate(this.value)) {
      var me = this.form.build;

      // delete previous content
      me.innerHTML = '';
      $.ajax({
        type: 'POST',
        url: 'get_regtest.php',
        dataType: 'json',
        data: {query: 'SELECT DISTINCT `build_number` FROM `regtest_results` WHERE `date` = \'' + this.value +'\''},
        success: function(data) {
          var options = '';
          for (var i = 0; i < data.length; i++) {
            options += '<option value="' + data[i].build_number + '">' + data[i].build_number + '</option>';
          }
          me.innerHTML = options;
        }
      })
    }
  });
});
// -->
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
    <h1>SDCC - Regression Tests</h1>
    <table border="0" cellpadding="2" cellspacing="1" width="100%" bgcolor="white">
    <tbody>
      <tr>
        <td width="15%" valign="top"><?php echo(file_get_contents('./left_menu.inc'));?></td>
        <td valign="top" width="85%">
          <h2><a name="Database"></a>Regression Tests Database</h2>
          <p>
Download full <a href="download_regtests_db.php?compress=bz2">regression test results database</a> in csv.bz2 format.
          </p>
          <form name="regtest" onsubmit="return genHiddenWhere(this)" action="download_regtests_db.php" method="post">
            Download regression test results in csv format for<br />
            <table>
              <tr>
                <td align="right"><label for="date">Build date:</label></td>
                <td><input name="date" id="date" class="date-pick" /></td>
              </tr>
              <tr>
                <td align="right">Build number:</td>
                <td>
                  <select name="build">
                    <option></option>
                  </select>
                </td>
              </tr>
              <tr>
                <td align="right">Platform:</td>
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
            <input type="submit" value="Download CSV" />
          </form>
          <h2><a name="Diffs"></a>Regression Tests Diffs</h2>
          <table>
            <tr>
              <td>
<?php
  genForm('form1', $platforms, $targets);
?>
              </td>
              <td>
<?php
  genForm('form2', $platforms, $targets);
?>
              </td>
            </tr>
          </table>
          <button id="form" class="button positive" onclick="return buttonClick()">Show table</button>
          <!-- placeholder for table -->
          <div class="success"></div>
<?php include('./footer.php')?>
        </td>
      </tr>
    </tbody>
    </table>
  </div>
  </body>
</html>
