<?php
/*-------------------------------------------------------------------------
   get_regtest.php - get regression tests

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

$query = htmlspecialchars(trim($_REQUEST['query']));

$regTestDb = new mysqli('mysql-s', 's599ro', 'riaPhiUp', 's599_regtests');

$res = array();
$result = $regTestDb->query($query);
if ($result) {
//  while ($row = $result->fetch_array(MYSQLI_NUM)) {
  while ($row = $result->fetch_assoc()) {
    $res[] = $row;
  }

  $result->free();
}

$regTestDb->close();

echo(json_encode($res));
?>
