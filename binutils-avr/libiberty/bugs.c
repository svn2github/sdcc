/* Bug report functions.
   Copyright (C) 1999 Free Software Foundation, Inc.

This file is part of the libiberty library.
Libiberty is free software; you can redistribute it and/or
modify it under the terms of the GNU Library General Public
License as published by the Free Software Foundation; either
version 2 of the License, or (at your option) any later version.

Libiberty is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Library General Public License for more details.

You should have received a copy of the GNU Library General Public
License along with libiberty; see the file COPYING.LIB.  If not,
write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
Boston, MA 02111-1307, USA.  */

#include <stdio.h>
#include "ansidecl.h"

extern void binutils_bug_report PARAMS((FILE *));

void
binutils_bug_report (stream)
    FILE *stream;
{
#if 0
  fprintf (stream, "Report bugs to bug-gnu-utils@gnu.org\n");
#else
  fprintf (stream, "Report bugs to bug-gnu-utils@gnu.org and hjl@lucon.org\n");
#endif
}
