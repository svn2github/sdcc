<?php
/*-------------------------------------------------------------------------
   update_regtest_db.php - update regression tests database with
                           regression test results

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

class RegTestDB extends mysqli {
  private $stmt_update;

  public function __construct($host, $username, $passwd, $dbname)
  {
    parent::__construct($host, $username, $passwd, $dbname);

    $query = "REPLACE INTO regtest_results (platform, target, build_number, date, regtest_name, failures, tests, cases, bytes, ticks) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    $this->stmt_update = $this->prepare($query);
  }

   function __destruct() {
    $this->stmt_update->close();
   }

  public function update($platform, $target, $build_number, $date, $regtest_name, $failures, $tests, $cases, $bytes, $ticks)
  {
    $this->stmt_update->bind_param('ssissiiiii', $platform, $target, $build_number, $date, $regtest_name, $failures, $tests, $cases, $bytes, $ticks);
    $res = $this->stmt_update->execute();
    if ($res === FALSE) {
      printf("Error: %s\n", $this->error);
    }
  }

  public function is_updated($platform, $target, $build_number, $date)
  {
    $query = "SELECT count(*) FROM regtest_results WHERE platform = ? AND target = ? AND build_number = ? AND date = ?";
    $stmt_is_updated = $this->prepare($query);
    $stmt_is_updated->bind_param('ssis', $platform, $target, $build_number, $date);
    $res = $stmt_is_updated->execute();
    if ($res === FALSE) {
      printf("Error: %s\n", $this->error);
      return false;
    }
    else {
      $stmt_is_updated->bind_result($count);
      $stmt_is_updated->fetch();
      $stmt_is_updated->close();
      return $count > 0;
    }
  }
}

$ini = parse_ini_file('sdcc.ini');
$regTestDb = new mysqli($ini['host'], $ini['username'], $ini['passwd'], $ini['dbname']);

if ($regTestDb->connect_error) {
  die('Connect Error (' . $regTestDb->connect_errno . ') ' . $regTestDb->connect_error);
}

// walk through all directories in ./regression_test_results
$d = dir('./regression_test_results');
while (false !== ($entry = $d->read())) {
  if (is_dir($d->path . '/' . $entry) && $entry[0] != '.') {
    $sd = dir($d->path . '/' . $entry);
    $platform = $entry;
    while (false !== ($sentry = $sd->read())) {
      if (is_file($sd->path . '/' . $sentry)) {
        $matches = array();
        if (preg_match ('/^regression-test-' . preg_quote($platform) . '-(\d{8})-(\d{4}).*\.log$/', $sentry, &$matches)) {
          $date = substr($matches[1], 0, 4) . '-' . substr($matches[1], 4, 2) . '-' . substr($matches[1], 6, 2);
          $build_number = $matches[2];
          $handle = fopen($sd->path . '/' . $sentry, 'r');
          if ($handle) {
            $do_process = true;
            while ($do_process && ($line = fgets($handle)) !== false) {
              // parse the line

              //Running host regression tests
              if (preg_match ('/^Running (.*) regression tests$/', $line, &$matches)) {
                $target = $matches[1];
                if ($regTestDb->is_updated($platform, $target, $build_number, $date)) {
                  // already updated: stop processing this file
                  $do_process = false;
                }
              }
              //abs                  (f: 0, t: 6, c: 1, b: 0, t: 0)
              else if (preg_match ('/^(\S+)\s+\(f: (\d*), t: (\d*), c: (\d*), b: (\d*), t: (\d*)\)$/', $line, &$matches)) {
                $regTestDb->update($platform, $target, $build_number, $date, $matches[1], $matches[2], $matches[3], $matches[4], $matches[5], $matches[6]);
              }
            }
          }
          fclose($handle);
        }
      }
    }
    $sd->close();
  }
}
$d->close();

$regTestDb->close();
?>
