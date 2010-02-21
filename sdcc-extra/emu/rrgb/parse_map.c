#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parse_map.h"

int
parse_map (char *file_name, pmarea * first_area)
{
  FILE *mapFP;
  char line[100];
  int section = 0, sub_sect = 0;

  pmarea current_area, *next_area;
  pmglobal current_global, *next_global = NULL;
  char tmp, *tmp2;

  next_area = first_area;
  current_area = NULL;

  mapFP = fopen (file_name, "r");

  if (mapFP)
    {
      while (fgets (line, 100, mapFP) != NULL)
        {
          if ((tmp2 = strchr (line, '\n')) != NULL)
            *tmp2 = '\0';

          if (line[0] != '\t')
            {
              /* Start of a new section */
              if (!strncmp (line, "AREA ", 5))
                {
                  /* Begin a new area section */
                  section = SECT_AREA;
                  *next_area = malloc (sizeof (marea));
                  current_area = *next_area;

                  strcpy (current_area->name, &line[5]);
                  current_area->next = NULL;
                  current_area->globals = NULL;
                  next_global = &current_area->globals;
                  current_area->base = 0;
                  current_area->size = 0;
                  next_area = &current_area->next;
                }
              else
                section = 0;
            }
          else
            {
              /* Data inside a section */
              if (section == SECT_AREA)
                {
                  if (line[1] != '\t')
                    {
                      if (!strncmp (line, "\tBASE ", 6))
                        {
                          sscanf (&line[6], "%x", &current_area->base);
                        }
                      if (!strncmp (line, "\tSIZE ", 6))
                        {
                          sscanf (&line[6], "%x", &current_area->size);
                        }
                      if (!strncmp (line, "\tGLOBALS", 8))
                        {
                          sub_sect = SECT_AREA_GLOBALS;
                        }
                    }
                  else
                    {
                      if (sub_sect == SECT_AREA_GLOBALS)
                        {
                          *next_global = malloc (sizeof (mglobal));
                          current_global = *next_global;
                          current_global->next = NULL;
                          current_global->sorted_next = NULL;
                          next_global = &current_global->next;

                          tmp2 = strrchr (line, '\t');
                          if (tmp2)
                            {
                              tmp = *tmp2;
                              *tmp2 = '\0';
                              strcpy (current_global->name, &line[2]);
                              *tmp2 = tmp;
                              sscanf (&tmp2[1], "%x", &current_global->addr);
                            }
                        }
                    }
                }
            }
        }
      fclose (mapFP);
    }
  else
    {
      return -1;
    }
  return 0;
}

int
global_compare (const void *glob1, const void *glob2)
{
  if ((*((pmglobal *) glob1))->addr < (*((pmglobal *) glob2))->addr)
    {
      return -1;
    }
  if ((*((pmglobal *) glob1))->addr > (*((pmglobal *) glob2))->addr)
    {
      return 1;
    }
  return 0;
}

int
sort_globals (pmglobal * first_global, pmarea first)
{
  pmglobal walk, *write_to;
  pmglobal *all_globals;
  int num_globals, i;

  if (first)
    {
      /* Create list of all globals */
      write_to = first_global;
      num_globals = 0;

      while (first)
        {
          walk = first->globals;
          while (walk)
            {
              *write_to = walk;
              write_to = &walk->sorted_next;
              num_globals++;
              walk = walk->next;
            }
          first = first->next;
        }
      *write_to = NULL;

      if (num_globals)
        {
          /* Create a linear array of pointers to these globals to sort them */
          all_globals = malloc (sizeof (pmglobal) * num_globals);
          walk = *first_global;
          i = 0;
          while (walk)
            {
              all_globals[i++] = walk;
              walk = walk->sorted_next;
            }

          qsort ((void *) all_globals, num_globals, sizeof (pmglobal), global_compare);

          for (i = 0; i < (num_globals - 1); i++)
            {
              all_globals[i]->sorted_next = all_globals[i + 1];
            }
          all_globals[num_globals - 1]->sorted_next = NULL;

          *first_global = all_globals[0];

          free (all_globals);
        }
    }

  return 0;
}
