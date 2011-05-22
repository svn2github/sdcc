<?php

class RegTestDB extends mysqli {
  public function __construct($host, $username, $passwd, $dbname)
  {
    parent::__construct($host, $username, $passwd, $dbname);
  }

  public function update($platform, $target, $build_number, $date, $regtest_name, $failures, $tests, $cases, $bytes, $ticks)
  {
    $query = "REPLACE INTO regtest_results (platform, target, build_number, date, regtest_name, failures, tests, cases, bytes, ticks) VALUES ('" .
      $platform . "', '" . $target . "', " . $build_number . ", '" . $date . "', '" . $regtest_name . "', " . $failures . ", " . $tests . ", " . $cases . ", " . $bytes . ", " . $ticks . ")";
#  echo($query . "<br />");
    $res = $this->query($query);
    if ($res === FALSE) {
      printf("Error: %s\n", $this->error);
    }
  }
}

$regTestDb = new RegTestDB('mysql-s', 's599rw', 'riaProEs', 's599_regtests');

if ($regTestDb->connect_error) {
    die('Connect Error (' . $regTestDb->connect_errno . ') ' . $regTestDb->connect_error);
}

$regTestDb->update("test", "ttt", 123, "2011-05-21", "regtest", 1, 2, 3, 4, 5);

echo('Success... ' . $regTestDb->host_info . "<br />");

$regTestDb->close();
?>
