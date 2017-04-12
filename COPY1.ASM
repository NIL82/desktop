.MODEL SMALL

DISP MACRO MSG
        MOV AH, 09H
        LEA DX, MSG
        INT 21H
ENDM

.DATA
        FILE1 DB 20 DUP(0)
        FILE2 DB 20 DUP(0)
        COUNT DW ?
        FHANDLE1 DW ?
        FHANDLE2 DW ?
        BUFF  DB 100, 0, 100 ('0')

        FOPEN           DB 10,13,"FILE OPENE SUCCESS$"
        FCLOSE          DB 10,13,"FILE CLOSE SUCCESS$"
        NAMEREAD        DB 10,13,"FILE NAMES READ SUCCESS$"
        FCOPY           DB 10,13,"FILE COPIED SUCCESS$"
        FCREATE         DB 10,13,"FILE CREATED SUCCESS$"
        FOPENERROR      DB 10,13,"FILE OPEN ERROR$"
        FCLOSEERROR      DB 10,13,"FILE CLOSE ERROR$"
        FREADERROR      DB 10,13,"FILE READ ERROR$"
        FCREATEERROR    DB 10,13,"FILE CREATE ERROR$"
.CODE
START:
        MOV AX, @DATA
        MOV DS, AX

;************READ FILE NAMES*******************

        MOV SI, 82H
        LEA DI, FILE1
UP1:
        MOV AL, ES:[SI]
        CMP AL, " "
        JE DOWN1
        MOV [DI], AL
        INC SI
        INC DI
        JMP UP1
DOWN1:
        INC SI
        LEA DI, FILE2
UP2:
        MOV AL, ES:[SI]
        CMP AL, 0DH
        JE READCOMPLETE
        MOV [DI], AL
        INC SI
        INC DI
        JMP UP2
READCOMPLETE:
        DISP NAMEREAD

;******************OPEN FILE1 READ MODE*******************

        MOV AH, 3DH
        LEA DX, FILE1
        MOV AL, 02H
        INT 21H

        JNC OPENSUCCESS
        DISP FOPENERROR
        JMP EXIT
OPENSUCCESS:
        MOV FHANDLE1, AX
        DISP FOPEN

;*****************CREATE FILE2*****************************

        MOV AH, 3CH
        LEA DX, FILE2
        XOR CX, CX
        INT 21H

        JNC CREATESUCCESS
        DISP FCREATEERROR
        JMP EXIT
CREATESUCCESS:
        DISP FCREATE

;******************OPEN FILE2 IN WRITE MODE

        MOV AH, 3DH
        LEA DX, FILE2
        MOV AL, 01H
        INT 21H

        JNC OPENSUCCESS2
        DISP FOPENERROR
        JMP EXIT
OPENSUCCESS2:
        MOV FHANDLE2, AX
        DISP FOPEN

;******************READ DATA FROM FILE1*************

FREAD:  MOV AH,3FH       
        MOV BX,FHANDLE1  ;READ FROM FILE1
	MOV CX,100
	LEA DX,BUFF
	INT 21H
	
        JC READERROR1
	
	CMP AX,0000   
	JE CLOSE      
		
;*********************NOW WRITE THE BYTES TO ANOTHER FILE**************************
	
	MOV COUNT,AX   
		
	MOV AH,40H         ;INT 21H FUNCTION FOR WRITING TO A FILE
        MOV BX,FHANDLE2    ;WRITE IN FILE2
        MOV CX,COUNT       ;NUMBER OF BYTES TO WRITE
	LEA DX,BUFF        ;BUFFER FROM WHICH DATA IS WRITTEN TO FILE
	INT 21H
		
	JMP FREAD         ;CONTINUE READING AND WRITING UNTILL END OF FILE1 IS REACHED
READERROR1:
        DISP FREADERROR
        JMP EXIT
CLOSE:
        MOV AH, 3EH
        MOV BX, FHANDLE1
        INT 21H
        JC CLOSEERROR
        MOV BX, FHANDLE2
        MOV AH, 3EH
        INT 21H
        JC CLOSEERROR

        DISP FCLOSE
        JMP EXIT
CLOSEERROR:
        DISP FCLOSEERROR
        JMP EXIT
EXIT:
        MOV AH, 4CH
        INT 21H
END START
END












