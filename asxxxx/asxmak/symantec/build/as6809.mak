ORIGIN		= Symantec C++
ORIGIN_VER	= Version 7.20
VERSION		= RELEASE

!IFDEF SUB_DEBUG
DEBUG		= $(SUB_DEBUG)
NDEBUG		= !$(SUB_DEBUG)
!ELSE
DEBUG		= 0
NDEBUG		= 1
!ENDIF

PROJ		= as6809
APPTYPE		= DOSX EXE
PROJTYPE	= EXE

CC		= SC
CPP		= SPP
MAKE		= SMAKE
RC		= RCC
HC		= HC31
ASM		= SC
DISASM		= OBJ2ASM
LNK		= LINK
DLLS		= 

HEADERS		= F:\SC\INCLUDE\stdio.h F:\SC\INCLUDE\setjmp.h ..\..\..\asxxsrc\asxxxx.h  \
		..\..\..\AS6809\m6809.h F:\SC\INCLUDE\string.h F:\SC\INCLUDE\alloc.h F:\SC\INCLUDE\stdlib.h 

DEFFILE		= as6809.DEF

!IF $(DEBUG)
OUTPUTDIR	= .
CREATEOUTPUTDIR	=
TARGETDIR	= .
CREATETARGETDIR	=

LIBS		= 

CFLAGS		=  -mx -C -S -3 -a4 -c -g -gd 
LFLAGS		=  /CO /DE /XN
DEFINES		= 
!ELSE
OUTPUTDIR	= c:\asxxxx\asxmak\symantec\build
!IF EXIST (c:\asxxxx\asxmak\symantec\build)
CREATEOUTPUTDIR	=
!ELSE
CREATEOUTPUTDIR	= if not exist $(OUTPUTDIR)\*.* md $(OUTPUTDIR)
!ENDIF
TARGETDIR	= c:\asxxxx\asxmak\symantec\exe
!IF EXIST (c:\asxxxx\asxmak\symantec\exe)
CREATETARGETDIR	=
!ELSE
CREATETARGETDIR	= if not exist $(TARGETDIR)\*.* md $(TARGETDIR)
!ENDIF

LIBS		= 

CFLAGS		=  -A -r -J -mx -o+time -3 -a4 -c 
LFLAGS		=  /DE /PACKF /XN
DEFINES		= 
!ENDIF

HFLAGS		= $(CFLAGS) 
MFLAGS		= MASTERPROJ=$(PROJ) 
LIBFLAGS	=  /C 
RESFLAGS	=  -32 
DEBUGGERFLAGS	=  
AFLAGS		= $(CFLAGS) 
HELPFLAGS	= 

MODEL		= N

PAR		= PROJS BATS OBJS

RCDEFINES	= 

INCLUDES	= -Ic:\asxxxx\asxxsrc

INCLUDEDOBJS	= 

OBJS		=  $(OUTPUTDIR)\ASDATA.OBJ  $(OUTPUTDIR)\ASEXPR.OBJ  $(OUTPUTDIR)\ASLEX.OBJ  \
		 $(OUTPUTDIR)\ASLIST.OBJ  $(OUTPUTDIR)\ASMAIN.OBJ  $(OUTPUTDIR)\ASOUT.OBJ  $(OUTPUTDIR)\ASSUBR.OBJ  \
		 $(OUTPUTDIR)\ASSYM.OBJ  $(OUTPUTDIR)\M09ADR.OBJ  $(OUTPUTDIR)\M09EXT.OBJ  $(OUTPUTDIR)\M09MCH.OBJ  \
		 $(OUTPUTDIR)\M09PST.OBJ 

RCFILES		= 

RESFILES	= 

SYMS		= 

HELPFILES	= 

BATS		= 

.SUFFIXES: .C .CP .CPP .CXX .CC .H .HPP .HXX .COM .EXE .DLL .LIB .RTF .DLG .ASM .RES .RC .OBJ 

.C.OBJ:
	$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$*.obj $*.c

.CPP.OBJ:
	$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$*.obj $*.cpp

.CXX.OBJ:
	$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$*.obj $*.cxx

.CC.OBJ:
	$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$*.obj $*.cc

.CP.OBJ:
	$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$*.obj $*.cp

.H.SYM:
	$(CC) $(HFLAGS) $(DEFINES) $(INCLUDES) -HF -o$(*B).sym $*.h

.HPP.SYM:
	$(CC) $(HFLAGS) $(DEFINES) $(INCLUDES) -HF -o$(*B).sym $*.hpp

.HXX.SYM:
	$(CC) $(HFLAGS) $(DEFINES) $(INCLUDES) -HF -o$(*B).sym $*.hxx

.C.EXP:
	$(CPP) $(CFLAGS) $(DEFINES) $(INCLUDES)   $*.c   -o$*.lst

.CPP.EXP:
	$(CPP) $(CFLAGS) $(DEFINES) $(INCLUDES) $*.cpp -o$*.lst

.CXX.EXP:
	$(CPP) $(CFLAGS) $(DEFINES) $(INCLUDES) $*.cxx -o$*.lst

.CP.EXP:
	$(CPP) $(CFLAGS) $(DEFINES) $(INCLUDES)  $*.cp  -o$*.lst

.CC.EXP:
	$(CPP) $(CFLAGS) $(DEFINES) $(INCLUDES)  $*.cc  -o$*.lst

.ASM.EXP:
	$(CPP) $(CFLAGS) $(DEFINES) $(INCLUDES) $*.asm -o$*.lst

.OBJ.COD:
	$(DISASM) $*.OBJ -c

.OBJ.EXE:
	$(LNK) $(LFLAGS) @$(PROJ).LNK

.RTF.HLP:
	$(HC) $(HELPFLAGS) $*.HPJ

.ASM.OBJ:
	$(ASM) $(AFLAGS) $(DEFINES) $(INCLUDES) -o$*.obj $*.asm

.RC.RES: 
	$(RC) $(RCDEFINES) $(RESFLAGS) $(INCLUDES) $*.rc -o$*.res

.DLG.RES:
	echo ^#include "windows.h" >$$$*.rc
	echo ^IF EXIST "$*.h" >>$$$*.rc
	echo ^#include "$*.h" >>$$$*.rc
	echo ^#include "$*.dlg" >>$$$*.rc
	$(RC) $(RCDEFINES) $(RESFLAGS) $(INCLUDES) $$$*.rc
	-del $*.res
	-ren $$$*.res $*.res



all:	createdir $(PRECOMPILE) $(SYMS) $(OBJS) $(INCLUDEDOBJS) $(POSTCOMPILE) $(TARGETDIR)\$(PROJ).$(PROJTYPE) $(POSTLINK) _done

createdir:
	$(CREATEOUTPUTDIR)
	$(CREATETARGETDIR)

$(TARGETDIR)\$(PROJ).$(PROJTYPE): $(OBJS) $(INCLUDEDOBJS) $(RCFILES) $(RESFILES) $(HELPFILES) 
			-del $(TARGETDIR)\$(PROJ).$(PROJTYPE)
			$(LNK) $(LFLAGS) @$(PROJ).LNK;
			-ren $(TARGETDIR)\$$SCW$$.$(PROJTYPE) $(PROJ).$(PROJTYPE)
			-echo $(TARGETDIR)\$(PROJ).$(PROJTYPE) built

_done:
		-echo $(PROJ).$(PROJTYPE) done

buildall:	clean	all


clean:
		-del $(TARGETDIR)\$$SCW$$.$(PROJTYPE)
		-del $(TARGETDIR)\$(PROJ).CLE
		-del $(OUTPUTDIR)\SCPH.SYM
		-del as6809.dpd
		-del $(OBJS)

cleanres:

res:		cleanres $(RCFILES) all


link:
		$(LNK) $(LFLAGS) @$(PROJ).LNK;
		-del $(TARGETDIR)\$(PROJ).$(PROJTYPE)
		-ren $(TARGETDIR)\$$SCW$$.$(PROJTYPE) $(PROJ).$(PROJTYPE)




!IF EXIST (as6809.dpd)
!INCLUDE as6809.dpd
!ENDIF



$(OUTPUTDIR)\ASDATA.OBJ:	..\..\..\ASXXSRC\ASDATA.C
		$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$(OUTPUTDIR)\ASDATA.obj ..\..\..\ASXXSRC\ASDATA.C



$(OUTPUTDIR)\ASEXPR.OBJ:	..\..\..\ASXXSRC\ASEXPR.C
		$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$(OUTPUTDIR)\ASEXPR.obj ..\..\..\ASXXSRC\ASEXPR.C



$(OUTPUTDIR)\ASLEX.OBJ:	..\..\..\ASXXSRC\ASLEX.C
		$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$(OUTPUTDIR)\ASLEX.obj ..\..\..\ASXXSRC\ASLEX.C



$(OUTPUTDIR)\ASLIST.OBJ:	..\..\..\ASXXSRC\ASLIST.C
		$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$(OUTPUTDIR)\ASLIST.obj ..\..\..\ASXXSRC\ASLIST.C



$(OUTPUTDIR)\ASMAIN.OBJ:	..\..\..\ASXXSRC\ASMAIN.C
		$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$(OUTPUTDIR)\ASMAIN.obj ..\..\..\ASXXSRC\ASMAIN.C



$(OUTPUTDIR)\ASOUT.OBJ:	..\..\..\ASXXSRC\ASOUT.C
		$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$(OUTPUTDIR)\ASOUT.obj ..\..\..\ASXXSRC\ASOUT.C



$(OUTPUTDIR)\ASSUBR.OBJ:	..\..\..\ASXXSRC\ASSUBR.C
		$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$(OUTPUTDIR)\ASSUBR.obj ..\..\..\ASXXSRC\ASSUBR.C



$(OUTPUTDIR)\ASSYM.OBJ:	..\..\..\ASXXSRC\ASSYM.C
		$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$(OUTPUTDIR)\ASSYM.obj ..\..\..\ASXXSRC\ASSYM.C



$(OUTPUTDIR)\M09ADR.OBJ:	..\..\..\AS6809\M09ADR.C
		$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$(OUTPUTDIR)\M09ADR.obj ..\..\..\AS6809\M09ADR.C



$(OUTPUTDIR)\M09EXT.OBJ:	..\..\..\AS6809\M09EXT.C
		$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$(OUTPUTDIR)\M09EXT.obj ..\..\..\AS6809\M09EXT.C



$(OUTPUTDIR)\M09MCH.OBJ:	..\..\..\AS6809\M09MCH.C
		$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$(OUTPUTDIR)\M09MCH.obj ..\..\..\AS6809\M09MCH.C



$(OUTPUTDIR)\M09PST.OBJ:	..\..\..\AS6809\M09PST.C
		$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$(OUTPUTDIR)\M09PST.obj ..\..\..\AS6809\M09PST.C




