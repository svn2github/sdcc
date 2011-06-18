<?php
/*-------------------------------------------------------------------------
   download_regtest_db.php - download regression tests database
                             in CSV format

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

class Out {
  protected $fileExt;
  protected $view;
  protected $encoding;

  function gen_http_header()
  {
  }

  function prolog()
  {
  }

  function epilog()
  {
  }

  function gen_head($row)
  {
  }

  function gen_row($row)
  {
  }

  function close()
  {
  }
}

class Csv extends Out {
  protected $outstream;

  function __construct($view, $encoding = 'windows-1250')
  {
    $this->view = $view;
    $this->encoding = $encoding;
    $this->fileExt = '.csv';
    $this->outstream = fopen('php://output', 'w');
  }

  function gen_http_header()
  {
    header('Cache-Control: no-store, no-cache, must-revalidate, post-check=0, pre-check=0');
    header('Expires: Sun, 22 May 2011 00:00:00 GMT');
    header('Content-Type: application/ms-excel; charset=' . $this->encoding);
    header('Content-Disposition: attachment; filename="' . $this->view . $this->fileExt . '"');
  }

  function gen_head($row)
  {
    $this->gen_row($row);
  }

  protected function recode_elem($elem)
  {
    if ($this->encoding != 'utf-8') {
      return iconv('utf-8', $this->encoding . '//IGNORE', $elem);
    }
    else {
      return $elem;
    }
  }

  function gen_row($row)
  {
    $row1 = array_map(array($this, 'recode_elem'), $row);
    return fputcsv($this->outstream, $row1, ';');
  }

  function close()
  {
    fclose($this->outstream);
  }
}

class Bz2Csv extends Csv {
  protected $bz2stream;
  protected $tempfname;

  function __construct($view, $encoding = 'windows-1250')
  {
    $this->view = $view;
    $this->encoding = $encoding;
    $this->fileExt = '.csv.bz2';
    $this->tempfname = tempnam(sys_get_temp_dir(), 'sdcc');
    $this->bz2stream = bzopen($this->tempfname, 'w');
    $this->outstream = fopen('php://memory', 'rw');
  }

  function gen_http_header()
  {
    header('Cache-Control: no-store, no-cache, must-revalidate, post-check=0, pre-check=0');
    header('Expires: Sun, 22 May 2011 00:00:00 GMT');
    header('Content-Type: application/octet-stream');
    header('Content-Disposition: attachment; filename="' . $this->view . $this->fileExt . '"');
    header('Content-Transfer-Encoding: binary');
    ob_flush();
  }

  function gen_row ($row)
  {
    rewind($this->outstream);                         // rewind the memory stream
    $len = parent::gen_row($row);
    rewind($this->outstream);                         // rewind the memory stream
    $csvstr = stream_get_contents($this->outstream);  // read csv from the memory stream
    $ret = bzwrite($this->bz2stream, $csvstr, $len);  // write csv from the bzip2 stream
  }

  function close()
  {
    fclose($this->outstream);
    bzclose($this->bz2stream);
    readfile($this->tempfname);
    unlink($this->tempfname);
  }
}

$where = htmlspecialchars(trim($_REQUEST['where']));
$compress = htmlspecialchars(trim($_REQUEST['compress']));

$ini = parse_ini_file('sdcc.ini');
$regTestDb = new mysqli($ini['host'], $ini['username'], $ini['passwd'], $ini['dbname']);

$query = 'SELECT * FROM regtest_results';
if ($where) {
  $query .= ' WHERE ' . $where;
}

$result = $regTestDb->query($query);
if ($result) {
  if ($compress == 'bz2') {
    $out = new Bz2Csv('regression_test_results');
  
  }
  else {
    $out = new Csv('regression_test_results');
  }

  $out->gen_http_header();

  $out->prolog($view);

  $out->gen_head(array('platform', 'target', 'build_number', 'date', 'regtest_name', 'failures', 'tests', 'cases', 'bytes', 'ticks', 'time_stamp'));

  while ($row = $result->fetch_assoc()) {
    $out->gen_row($row);
  }

  $out->epilog();
  $out->close();
  $result->free();
}
else {
  echo('DB Error: could not execute the database quey = ' . $query . "\n");
  echo('MySQL Error: ' . $regTestDb->error . "\n");
}

$regTestDb->close();
?>
