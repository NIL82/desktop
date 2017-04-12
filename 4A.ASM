.MODEL SMALL
.STACK 100

DISP MACRO MSG      ;DEFINING MACRO
        MOV AH,09H
        LEA DX,MSG
        INT 21H
ENDM

EXTRN ACCEPT:FAR
EXTRN COMP:FAR
EXTRN CONCAT:FAR
EXTRN SUBSTRING:FAR

PUBLIC STR1
PUBLIC STR2
PUBLIC STR3

.DATA
        STR1 DB 25H DUP('$')         ;STRINGS DECLARATION
        STR2 DB 25H DUP('$')
        STR3 DB 25H DUP('$')
        CTR DB 25H

       MENU DB 10,13,"********* MENU ******** "
            DB 10,13,"1. COMPARE TWO STRINGS "
            DB 10,13,"2. CONCAT TWO STRINGS"           
            DB 10,13,"3. FIND SUBSTRING "
            DB 10,13,"4. EXIT "
            DB 10,13," ENTER YOUR CHOICE $"       
.CODE
        MOV AX,@DATA
        MOV DS,AX
        MOV ES,AX
A: 
	DISP MENU
        MOV AH,01H           ;COMPARING USER CHOICE
        INT 21H

        CMP AL,31H
        JE  M1   
        CMP AL,32H       
        JE M2
        CMP AL,33H
        JE M3
        CMP AL,34H
        JE M4
M1:
	CALL COMP        ;CALLING PROCS AS PER CHOICE
        JMP A
M2:
	CALL CONCAT
        JMP A
M3:
	CALL SUBSTRING
        JMP A
M4:
	MOV AH,4CH       ;TERMINATION
        INT 21H
END                 	;END OF PROG
              

