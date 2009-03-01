/* This file is tc-avr.h
   Copyright (C) 1999 by Denis Chertykov <denisc@overta.ru>

   This file is part of GAS, the GNU Assembler.

   GAS is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   GAS is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with GAS; see the file COPYING.  If not, write to the Free
   Software Foundation, 59 Temple Place - Suite 330, Boston, MA
   02111-1307, USA.  */

#ifndef BFD_ASSEMBLER
 #error AVR support requires BFD_ASSEMBLER
#endif


#define TC_AVR
/*   By convention, you should define this macro in the `.h' file.  For
     example, `tc-m68k.h' defines `TC_M68K'.  You might have to use this
     if it is necessary to add CPU specific code to the object format
     file. */

#define TARGET_FORMAT "elf32-avr"
/*   This macro is the BFD target name to use when creating the output
     file.  This will normally depend upon the `OBJ_FMT' macro. */

#define TARGET_ARCH bfd_arch_avr
/*   This macro is the BFD architecture to pass to `bfd_set_arch_mach'. */

#define TARGET_MACH 0
/*   This macro is the BFD machine number to pass to
     `bfd_set_arch_mach'.  If it is not defined, GAS will use 0. */

#define TARGET_BYTES_BIG_ENDIAN 0
/*   You should define this macro to be non-zero if the target is big
     endian, and zero if the target is little endian. */

/*
`md_shortopts'
`md_longopts'
`md_longopts_size'
`md_parse_option'
`md_show_usage'
     GAS uses these variables and functions during option processing.
     `md_shortopts' is a `const char *' which GAS adds to the machine
     independent string passed to `getopt'.  `md_longopts' is a `struct
     option []' which GAS adds to the machine independent long options
     passed to `getopt'; you may use `OPTION_MD_BASE', defined in
     `as.h', as the start of a set of long option indices, if necessary.
     `md_longopts_size' is a `size_t' holding the size `md_longopts'.
     GAS will call `md_parse_option' whenever `getopt' returns an
     unrecognized code, presumably indicating a special code value
     which appears in `md_longopts'.  GAS will call `md_show_usage'
     when a usage message is printed; it should print a description of
     the machine specific options.
*/

#define ONLY_STANDARD_ESCAPES
/*   If you define this macro, GAS will warn about the use of
     nonstandard escape sequences in a string. */
/* XXX??
`md_parse_name'
     If this macro is defined, GAS will call it for any symbol found in
     an expression.  You can define this to handle special symbols in a
     special way.  If a symbol always has a certain value, you should
     normally enter it in the symbol table, perhaps using `reg_section'. */
/*
`md_undefined_symbol'
     GAS will call this function when a symbol table lookup fails,
     before it creates a new symbol.  Typically this would be used to
     supply symbols whose name or value changes dynamically, possibly
     in a context sensitive way.  Predefined symbols with fixed values,
     such as register names or condition codes, are typically entered
     directly into the symbol table when `md_begin' is called. */

#define md_operand(x)
/*   GAS will call this function for any expression that can not be
     recognized.  When the function is called, `input_line_pointer'
     will point to the start of the expression. */
/*
`tc_unrecognized_line'
     If you define this macro, GAS will call it when it finds a line
     that it can not parse.*/
/*
`md_do_align'
     You may define this macro to handle an alignment directive.  GAS
     will call it when the directive is seen in the input file.  For
     example, the i386 backend uses this to generate efficient nop
     instructions of varying lengths, depending upon the number of
     bytes that the alignment will skip. */
/*
`HANDLE_ALIGN'
     You may define this macro to do special handling for an alignment
     directive.  GAS will call it at the end of the assembly. */

void avr_parse_cons_expression (expressionS *exp, int nbytes);
#define TC_PARSE_CONS_EXPRESSION(EXPR,N) avr_parse_cons_expression (EXPR,N)
/*
     You may define this macro to parse an expression used in a data
     allocation pseudo-op such as `.word'.  You can use this to
     recognize relocation directives that may appear in such directives.*/

void avr_cons_fix_new(fragS *frag,int where, int nbytes, expressionS *exp);

#define TC_CONS_FIX_NEW(FRAG,WHERE,N,EXP) avr_cons_fix_new(FRAG,WHERE,N,EXP)
/* 
     You may define this macro to generate a fixup for a data
     allocation pseudo-op. */
/* XXX
`BITFIELD_CONS_EXPRESSION'
     If you define this macro, GAS will recognize bitfield instructions
     in data allocation pseudo-ops, as used on the i960. */
/*
`REPEAT_CONS_EXPRESSION'
     If you define this macro, GAS will recognize repeat counts in data
     allocation pseudo-ops, as used on the MIPS.*/
/*
`md_cons_align'
     You may define this macro to do any special alignment before a
     data allocation pseudo-op.*/
/*`TC_INIT_FIX_DATA (FIXP)'
     A C statement to initialize the target specific fields of fixup
     FIXP.  These fields are defined with the `TC_FIX_TYPE' macro. */
/*
`TC_FIX_DATA_PRINT (STREAM, FIXP)'
     A C statement to output target specific debugging information for
     fixup FIXP to STREAM.  This macro is called by `print_fixup'. */
/*
`TC_FRAG_INIT (FRAGP)'
     A C statement to initialize the target specific fields of frag
     FRAGP.  These fields are defined with the `TC_FRAG_TYPE' macro. */

#define md_number_to_chars number_to_chars_littleendian
/*   This should just call either `number_to_chars_bigendian' or
     `number_to_chars_littleendian', whichever is appropriate.  On
     targets like the MIPS which support options to change the
     endianness, which function to call is a runtime decision.  On
     other targets, `md_number_to_chars' can be a simple macro. */

#define WORKING_DOT_WORD
/*
`md_short_jump_size'
`md_long_jump_size'
`md_create_short_jump'
`md_create_long_jump'
     If `WORKING_DOT_WORD' is defined, GAS will not do broken word
     processing (*note Broken words::.).  Otherwise, you should set
     `md_short_jump_size' to the size of a short jump (a jump that is
     just long enough to jump around a long jmp) and
     `md_long_jump_size' to the size of a long jump (a jump that can go
     anywhere in the function), You should define
     `md_create_short_jump' to create a short jump around a long jump,
     and define `md_create_long_jump' to create a long jump. */

#define MD_APPLY_FIX3
/*
`TC_HANDLES_FX_DONE'
     If this macro is defined, it means that `md_apply_fix' correctly
     sets the `fx_done' field in the fixup. */

#undef RELOC_EXPANSION_POSSIBLE
/*   If you define this macro, it means that `tc_gen_reloc' may return
     multiple relocation entries for a single fixup.  In this case, the
     return value of `tc_gen_reloc' is a pointer to a null terminated
     array. */
/*
`MAX_RELOC_EXPANSION'
     You must define this if `RELOC_EXPANSION_POSSIBLE' is defined; it
     indicates the largest number of relocs which `tc_gen_reloc' may
     return for a single fixup. */

/* XXX ???
`tc_fix_adjustable'
     You may define this macro to indicate whether a fixup against a
     locally defined symbol should be adjusted to be against the
     section symbol.  It should return a non-zero value if the
     adjustment is acceptable. */

#define MD_PCREL_FROM_SECTION(FIXP, SEC) md_pcrel_from_section(FIXP, SEC)   
/*   If you define this macro, it should return the offset between the
     address of a PC relative fixup and the position from which the PC
     relative adjustment should be made.  On many processors, the base
     of a PC relative instruction is the next instruction, so this
     macro would return the length of an instruction. */

#define LISTING_WORD_SIZE 2
/*   The number of bytes to put into a word in a listing.  This affects
     the way the bytes are clumped together in the listing.  For
     example, a value of 2 might print `1234 5678' where a value of 1
     would print `12 34 56 78'.  The default value is 4. */

