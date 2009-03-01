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

PROJ		= ASLINK
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

HEADERS		= F:\SC\INCLUDE\stdio.h F:\SC\INCLUDE\string.h F:\SC\INCLUDE\alloc.h  \
		F:\SC\INCLUDE\stdlib.h ..\..\..\LINKSRC\aslink.h 

DEFFILE		= aslink.DEF

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

INCLUDES	= -Ic:\asxxxx\linksrc

INCLUDEDOBJS	= 

OBJS		=  $(OUTPUTDIR)\LKAREA.OBJ  $(OUTPUTDIR)\LKDATA.OBJ  $(OUTPUTDIR)\LKEVAL.OBJ  \
		 $(OUTPUTDIR)\LKHEAD.OBJ  $(OUTPUTDIR)\LKLEX.OBJ  $(OUTPUTDIR)\LKLIBR.OBJ  $(OUTPUTDIR)\LKLIST.OBJ  \
		 $(OUTPUTDIR)\LKMAIN.OBJ  $(OUTPUTDIR)\LKRLOC.OBJ  $(OUTPUTDIR)\LKSYM.OBJ  $(OUTPUTDIR)\lkout.OBJ 

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
		-del ASLINK.dpd
		-del $(OBJS)

cleanres:

res:		cleanres $(RCFILES) all


link:
		$(LNK) $(LFLAGS) @$(PROJ).LNK;
		-del $(TARGETDIR)\$(PROJ).$(PROJTYPE)
		-ren $(TARGETDIR)\$$SCW$$.$(PROJTYPE) $(PROJ).$(PROJTYPE)




!IF EXIST (ASLINK.dpd)
!INCLUDE ASLINK.dpd
!ENDIF



$(OUTPUTDIR)\LKAREA.OBJ:	..\..\..\LINKSRC\LKAREA.C
		$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$(OUTPUTDIR)\LKAREA.obj ..\..\..\LINKSRC\LKAREA.C



$(OUTPUTDIR)\LKDATA.OBJ:	..\..\..\LINKSRC\LKDATA.C
		$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$(OUTPUTDIR)\LKDATA.obj ..\..\..\LINKSRC\LKDATA.C



$(OUTPUTDIR)\LKEVAL.OBJ:	..\..\..\LINKSRC\LKEVAL.C
		$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$(OUTPUTDIR)\LKEVAL.obj ..\..\..\LINKSRC\LKEVAL.C



$(OUTPUTDIR)\LKHEAD.OBJ:	..\..\..\LINKSRC\LKHEAD.C
		$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$(OUTPUTDIR)\LKHEAD.obj ..\..\..\LINKSRC\LKHEAD.C



$(OUTPUTDIR)\LKLEX.OBJ:	..\..\..\LINKSRC\LKLEX.C
		$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$(OUTPUTDIR)\LKLEX.obj ..\..\..\LINKSRC\LKLEX.C



$(OUTPUTDIR)\LKLIBR.OBJ:	..\..\..\LINKSRC\LKLIBR.C
		$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$(OUTPUTDIR)\LKLIBR.obj ..\..\..\LINKSRC\LKLIBR.C



$(OUTPUTDIR)\LKLIST.OBJ:	..\..\..\LINKSRC\LKLIST.C
		$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$(OUTPUTDIR)\LKLIST.obj ..\..\..\LINKSRC\LKLIST.C



$(OUTPUTDIR)\LKMAIN.OBJ:	..\..\..\LINKSRC\LKMAIN.C
		$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$(OUTPUTDIR)\LKMAIN.obj ..\..\..\LINKSRC\LKMAIN.C



$(OUTPUTDIR)\LKRLOC.OBJ:	..\..\..\LINKSRC\LKRLOC.C
		$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$(OUTPUTDIR)\LKRLOC.obj ..\..\..\LINKSRC\LKRLOC.C



$(OUTPUTDIR)\LKSYM.OBJ:	..\..\..\LINKSRC\LKSYM.C
		$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$(OUTPUTDIR)\LKSYM.obj ..\..\..\LINKSRC\LKSYM.C



$(OUTPUTDIR)\lkout.OBJ:	..\..\..\LINKSRC\lkout.c
		$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o$(OUTPUTDIR)\lkout.obj ..\..\..\LINKSRC\lkout.c




