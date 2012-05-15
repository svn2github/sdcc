<?php
/*-------------------------------------------------------------------------
   update_regtest_db.php - update regression tests database with
                           regression test results

   Copyright (C) 2011, 2012 Borut Razem <borut.razem AT gmail.com>

   This program is free software; you can redistribute it and/or modify it
   under the terms of the GNU General Public License as published by the
   Free Software Foundation; either version 2, or (at your option) any
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

require_once('dbg.php');

class RegTestDB extends mysqli {
  private $stmt_update;

  public function __construct($host, $username, $passwd, $dbname)
  {
    parent::__construct($host, $username, $passwd, $dbname);

    $query = "REPLACE INTO regtest_results (platform, target, build_number, date, regtest_name, failures, tests, cases, bytes, ticks) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    if (!($this->stmt_update = $this->prepare($query))) {
      echo('Prepare failed: (' . $this->errno . ') ' . $this->error);
    }
  }

   function __destruct() {
    $this->stmt_update->close();
   }

  public function update($platform, $target, $build_number, $date, $regtest_name, $failures, $tests, $cases, $bytes, $ticks)
  {
    $this->stmt_update->bind_param('ssissiiiii', $platform, $target, $build_number, $date, $regtest_name, $failures, $tests, $cases, $bytes, $ticks);
    $res = $this->stmt_update->execute();
    if ($res === FALSE) {
      echo('Execute failed: (' . $this->errno . ') ' . $this->error);
    }
  }

  public function is_updated($platform, $target, $build_number, $date)
  {
    $query = "SELECT count(*) FROM regtest_results WHERE platform = ? AND target = ? AND build_number = ? AND date = ?";
    $stmt_is_updated = $this->prepare($query);
    $stmt_is_updated->bind_param('ssis', $platform, $target, $build_number, $date);
    $res = $stmt_is_updated->execute();
    if ($res === false) {
      echo('Execute failed: (' . $this->errno . ') ' . $this->error);
      return false;
    }
    else {
      $stmt_is_updated->bind_result($count);
      $stmt_is_updated->fetch();
      $stmt_is_updated->close();
      return $count > 0;
    }
  }

  public function is_file_updated($platform, $build_number, $date)
  {
    $query = "SELECT count(*) FROM regtest_results WHERE platform = ? AND build_number = ? AND date = ?";
    $stmt_is_updated = $this->prepare($query);
    $stmt_is_updated->bind_param('sis', $platform, $build_number, $date);
    $res = $stmt_is_updated->execute();
    if ($res === false) {
      echo('Execute failed: (' . $this->errno . ') ' . $this->error);
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

$dbg = new Dbg('log/regtest_dbg.log');

$ini = parse_ini_file('sdcc_rw.ini');
$regTestDb = new RegTestDB($ini['host'], $ini['username'], $ini['passwd'], $ini['dbname']);

if ($regTestDb->connect_error) {
  die('Connect failed: (' . $regTestDb->connect_errno . ') ' . $regTestDb->connect_error);
}

// walk through all directories in ./regression_test_results
$d = dir('./regression_test_results');
while (false !== ($entry = $d->read())) {
  //$dbg->dbg('Testing dir ' . $d->path . '/' . $entry);

  if (is_dir($d->path . '/' . $entry) && $entry[0] != '.') {
    $dbg->dbg('Processing dir ' . $d->path . '/' . $entry);

    $sd = dir($d->path . '/' . $entry);
    $platform = $entry;
    while (false !== ($sentry = $sd->read())) {
      //$dbg->dbg('  Testing file ' . $sd->path . '/' . $sentry);

      if (is_file($sd->path . '/' . $sentry)) {
        $matches = array();
        if (preg_match ('/^regression-test-' . preg_quote($platform) . '-(\d{8})-(\d{4}).*\.log$/', $sentry, &$matches)) {
          //$dbg->dbg('  Opening file ' . $sd->path . '/' . $sentry);

          $date = substr($matches[1], 0, 4) . '-' . substr($matches[1], 4, 2) . '-' . substr($matches[1], 6, 2);
          $build_number = $matches[2];

          if (!$regTestDb->is_file_updated($platform, $build_number, $date)) {
            $handle = fopen($sd->path . '/' . $sentry, 'r');
            if ($handle) {
              $dbg->dbg('  Processing file ' . $sd->path . '/' . $sentry);

              while (($line = fgets($handle)) !== false) {
                //$dbg->dbg('    Testing line ' . $line);
                // parse the line

                //Running host regression tests
                if (preg_match ('/^Running (.*) regression tests$/', $line, &$matches)) {
                  $target = $matches[1];

                  $dbg->dbg('    Processing target ' . $target);
                }
                //abs                  (f: 0, t: 6, c: 1, b: 0, t: 0)
                else if (preg_match ('/^(\S+)\s+\(f:\s*(\d*),\s*t:\s*(\d*),\s*c:\s*(\d*),\s*b:\s*(\d*),\s*t:\s*(\d*)\)$/', $line, &$matches)) {
                  $dbg->dbg('      Processing test ' . $matches[1]);
                  //$dbg->dbg('      update(' . $platform . ', ' . $target . ', ' . $build_number . ', ' . $date . ', ' . $matches[1] . ', ' . $matches[2] . ', ' . $matches[3] . ', ' . $matches[4] . ', ' . $matches[5] . ', ' . $matches[6] . ')');

                  $regTestDb->update($platform, $target, $build_number, $date, $matches[1], $matches[2], $matches[3], $matches[4], $matches[5], $matches[6]);
                }
                else {
                  $dbg->dbg('      Unprocessed: ' . $line);
                }
              }
              fclose($handle);
            }
            else {
              $dbg->dbg('  Can\'t open file ' . $sd->path . '/' . $sentry);
            }
          }
          else {
            $dbg->dbg('  Skipping file ' . $sd->path . '/' . $sentry);
          }
        }
      }
    }
    $sd->close();
  }
}
$d->close();

$regTestDb->close();
?>
