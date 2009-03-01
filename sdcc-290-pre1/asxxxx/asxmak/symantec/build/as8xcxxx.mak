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

PROJ		= as8xcxxx
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
		..\..\..\AS8XCXXX\ds8.h F:\SC\INCLUDE\string.h F:\SC\INCLUDE\alloc.h F:\SC\INCLUDE\stdlib.h 

DEFFILE		= as8xcxxx.DEF

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

CFLAGS		=  -A -J -mx -o+time -3 -a4 -c 
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

OBJS		=  $(OUTPUTDIR)\asdata.OBJ  $(OUTPUTDIR)\asexpr.OBJ  $(OUTPUTDIR)\aslex.OBJ  \
		 $(OUTPUTDIR)\aslist.OBJ  $(OUTPUTDIR)\asmain.OBJ  $(OUTPUTDIR)\asout.OBJ  $(OUTPUTDIR)\assubr.OBJ  \
		 $(OUTPUTDIR)\assym.OBJ  $(OUTPUTDIR)\ds8adr.OBJ  $(OUTPUTDIR)\ds8ext.OBJ  $(OUTPUTDIR)\ds8mch.OBJ  \
		 $(OUTPUTDIR)\ds8pst.OBJ 

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
		-del as8xcxxx.dpd
		-del $(OBJS)

cleanres:

res:		cleanres $(RCFILES) all


link:
		$(LNK) $(LFLAGS) @$(PROJ).LNK;
		-del $(TARGETDIR)\$(PROJ).$(PROJTYPE)
		-ren $(TARGETDIR)\$$SCW$$.$(PROJTYPE) $(PROJ).$(PROJTYPE)




!IF EXIST (as8xcxxx.dpd)
!INCLUDE as8xcxxx.dpd
!ENDIF



$(OUTPUTDIR)\asdata.OBJ:	..\..\..\ASXXSRC\asdata.c
		$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$(OUTPUTDIR)\asdata.obj ..\..\..\ASXXSRC\asdata.c



$(OUTPUTDIR)\asexpr.OBJ:	..\..\..\ASXXSRC\asexpr.c
		$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$(OUTPUTDIR)\asexpr.obj ..\..\..\ASXXSRC\asexpr.c



$(OUTPUTDIR)\aslex.OBJ:	..\..\..\ASXXSRC\aslex.c
		$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$(OUTPUTDIR)\aslex.obj ..\..\..\ASXXSRC\aslex.c



$(OUTPUTDIR)\aslist.OBJ:	..\..\..\ASXXSRC\aslist.c
		$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$(OUTPUTDIR)\aslist.obj ..\..\..\ASXXSRC\aslist.c



$(OUTPUTDIR)\asmain.OBJ:	..\..\..\ASXXSRC\asmain.c
		$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$(OUTPUTDIR)\asmain.obj ..\..\..\ASXXSRC\asmain.c



$(OUTPUTDIR)\asout.OBJ:	..\..\..\ASXXSRC\asout.c
		$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$(OUTPUTDIR)\asout.obj ..\..\..\ASXXSRC\asout.c



$(OUTPUTDIR)\assubr.OBJ:	..\..\..\ASXXSRC\assubr.c
		$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$(OUTPUTDIR)\assubr.obj ..\..\..\ASXXSRC\assubr.c



$(OUTPUTDIR)\assym.OBJ:	..\..\..\ASXXSRC\assym.c
		$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$(OUTPUTDIR)\assym.obj ..\..\..\ASXXSRC\assym.c



$(OUTPUTDIR)\ds8adr.OBJ:	..\..\..\AS8XCXXX\ds8adr.c
		$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$(OUTPUTDIR)\ds8adr.obj ..\..\..\AS8XCXXX\ds8adr.c



$(OUTPUTDIR)\ds8ext.OBJ:	..\..\..\AS8XCXXX\ds8ext.c
		$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$(OUTPUTDIR)\ds8ext.obj ..\..\..\AS8XCXXX\ds8ext.c



$(OUTPUTDIR)\ds8mch.OBJ:	..\..\..\AS8XCXXX\ds8mch.c
		$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$(OUTPUTDIR)\ds8mch.obj ..\..\..\AS8XCXXX\ds8mch.c



$(OUTPUTDIR)\ds8pst.OBJ:	..\..\..\AS8XCXXX\ds8pst.c
		$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$(OUTPUTDIR)\ds8pst.obj ..\..\..\AS8XCXXX\ds8pst.c




