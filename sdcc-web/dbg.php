<?php
/*-------------------------------------------------------------------------
   dbg.php - Dbg class implementation

   Copyright (C) 2012 Borut Razem <borut.razem AT gmail.com>

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

class Dbg {
  private $debug;
  private $fh;
  private $begin_time;

  private function d($s)
  {
    if (false) {
      echo($s . "<br />\n");
    }
  }

  public function __construct($fname = null, $do_append = false, $do_debug = true)
  {
    $this->d(__METHOD__);

    if ($fname !== null) {
      if ($do_append) {
        $mode = 'a';
      }
      else {
        $mode = 'w';
      }
      if (!($this->fh = fopen($fname, $mode))) {
        echo('Can\'t create ' . $fname . "\n");
      }
    }
    $this->debug = $do_debug;

    $this->begin_time = time();

    $this->dbg('--- Begin ' . date('Y-m-d H:i:s', $this->begin_time) . ' ---');
  }

  public function set_debug($val)
  {
    $this->d(__METHOD__);

    $this->debug = $val;
  }

  public function dbg($s)
  {
    $this->d(__METHOD__);

    if ($this->debug) {
      if ($this->fh) {
        fwrite($this->fh, $s . "\n");
      }
      else {
        echo($s . "<br />\n");
      }
    }
  }

  public function dbg_r($s)
  {
    $this->d(__METHOD__);

    if ($this->debug) {
      if ($this->fh) {
        fwrite($this->fh, print_r($s, true) . "\n");
      }
      else {
        print_r($s);
        echo("<br />\n");
      }
    }
  }

  public function __destruct()
  {
    $this->d(__METHOD__);

    $end_time = time();
    $this->dbg('--- End: ' . date('Y-m-d H:i:s', $end_time) .
      ', Duration: ' . ($end_time - $this->begin_time) . 's ---');

    if ($this->fh) {
      fclose($this->fh);
    }
  }
}
?>
