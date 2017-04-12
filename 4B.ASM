
DISP MACRO MSG          ;DEFINING MACRO FOR DISPLAY
	MOV AH,09H
	LEA DX,MSG
	INT 21H
ENDM

EXTRN STR1:BYTE         ;ACCESING VARIABLES
EXTRN STR2:BYTE
EXTRN STR3:BYTE


PUBLIC ACCEPT
PUBLIC COMP
PUBLIC CONCAT
PUBLIC SUBSTRING

.MODEL SMALL
.STACK 100

.DATA
        MSG1 DB 10,13,"ENTER 1ST  STRING $"
        MSG5 DB 10,13,"STRINGS ARE EQUAL... $"
        MSG6 DB 10,13,"STRINGS ARE NOT EQUAL... $"
        MSG4 DB 10,13,"ENTER 2ND STRING $"
        MSG7 DB 10,13,"CONCATED STRING IS--->    $"
        MSG8 DB 10,13,"NO OF WORDS ARE---->      $"
        MSG9 DB 10,13,"ENTER STRING TO FIND NO OF WORDS   $"
        MSG10 DB 10,13,"ENTERD STRING IS SUB-STRING OF PREVIOUS ONE$"
        MSG11 DB 10,13," NO OF OCCURANCE $"
        MSG12 DB 10,13,"ENTERD STRING IS NOT  SUB-STRING OF PREVIOUS ONE$"
 
.CODE
        MOV AX,@DATA
        MOV DS,AX
        MOV ES,AX

        MOV AH,4CH
        INT 21H

;******************** ACCEPT *************************
ACCEPT PROC FAR
        DISP MSG1

        MOV AH,0AH        ;ACCEPTING 1ST STRING
        LEA DX,STR1
        INT 21H

        DISP MSG4
                     
        MOV AH,0AH        ;ACCEPTING 2ND STRING
        LEA DX,STR2
        INT 21H
        RET
ENDP

;********************** COMPARE PROCEDURE *****
COMP PROC FAR
        CALL ACCEPT       ;ACCEPTING TO COMPARE

        LEA SI,STR1+1     ;LOADING 1ST STRING WITH SI
        MOV BL,[SI]
        LEA DI,STR2+1     ;LOADING 2ND STRING WITH DI
        MOV BH,[DI]
        CMP BL,BH         ;COMAPRING LENGTH
        JNE A12
        INC SI
        INC DI
        MOV CL,BL
        MOV CH,00H

        REPE CMPSB        ;COMPARING ACTUAL CHARACTERS
        JE Z1
A12:
	DISP MSG6         ;DISPLAY NOT EQUAL
        JMP R
Z1:
	DISP MSG5
R:
	RET
ENDP
        

;******** CONCAT ***********
CONCAT PROC FAR
        CALL ACCEPT       ;ACCEPTING TO CONCAT
        DISP MSG7
        LEA SI,STR1+1     ;LOADING 1ST STRINH WITH SI
        MOV CL,[SI]
        LEA DI,STR3+1     ;LOADING RESULT STRING WITH DI
        MOV [DI],CL
        INC SI
        INC DI
        REP MOVSB         ;COPYING 1ST STRING 
        LEA SI,STR2+1
        MOV CL,[SI]
        ADD STR3+1,CL
        INC SI
        REP MOVSB         ;MOVING 2ND STRING AFTER 1ST
        LEA DI,STR3+1
        MOV CL,[DI]
UP:
	INC DI
        MOV DL,[DI]
        MOV AH,02H
        INT 21H
        DEC CL
        JNZ UP
        RET
ENDP              ;END OF CONCAT PROC

;********* FINDING  SUBSTRING ********
SUBSTRING PROC FAR

        CALL ACCEPT
        MOV BL,00H        ; COUNTS OCCURANCE
        LEA DI,STR1       ; ACTUAL STRNG
        LEA SI,STR2       ; SUBSTRING
        ADD DI,02H        ; POINT TO FIRST CHARACTER IN ACTUAL STRING
L12:
        MOV CL,STR2+1     ;
        ADD SI,02H
        REPE CMPSB
        JNE S12
        INC BL
S12:	
	LEA SI,STR2
        MOV AL,[DI]
        CMP AL,'$'        ;COMPARE TILL END OF STRING
        JNE L12           ;CONTINUE
        JMP QUIT1

QUIT:
	DISP MSG10        ;DISPLAY->IS SUBSTRING
        DISP MSG11
        MOV DL,BL
        ADD DL,30H
        MOV AH,02H        ;DISPLAYING NO OF OCCARNCE
        INT 21H
        JMP QUIT2
QUIT1:
	CMP BL,00H
        JNE QUIT
        DISP MSG12       ;DISPLAY ->NOT SUBSTRING
QUIT2:
	RET
ENDP
END
                             

