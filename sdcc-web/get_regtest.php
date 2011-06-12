<?php
/*-------------------------------------------------------------------------
   get_regtest.php - get regression tests

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

$ini = parse_ini_file('sdcc.ini');
$regTestDb = new mysqli($ini['host'], $ini['username'], $ini['passwd'], $ini['dbname']);

$query = htmlspecialchars(trim($_REQUEST['query']));

$res = array();
$result = $regTestDb->query($query);
if ($result) {
  while ($row = $result->fetch_assoc()) {
    $res[] = $row;
  }

  $result->free();
}

$regTestDb->close();

echo(json_encode($res));
?>
