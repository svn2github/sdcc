<?php
/*-------------------------------------------------------------------------
   snap_head.php - snapshot builds page head

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
header("Cache-Control: max-age=3600, must-revalidate"); //HTTP/1.1
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
  <meta content="text/html; charset=UTF-8" http-equiv="content-type" />
  <title>SDCC - Snapshot Builds</title>
  <link type="text/css" href="styles/style.css" rel="stylesheet" />
  <link rel="shortcut icon" type="image/x-icon" href="/images/sdcc.ico" />
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
<a href="http://svn.code.sf.net/p/sdcc/code/trunk/sdcc/ChangeLog">
view the ChangeLog</a> directly from the Subversion repository.
          </p>
