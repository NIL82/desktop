.MODEL SMALL
.STACK
DISP MACRO A1
        MOV AH, 09H
        LEA DX, A1
        INT 21H
ENDM

.DATA
        STR1 DB 25 DUP('$')
        MSG DB 10,13,"*************MENU***********"
            DB 10,13,"1. ACCEPT STRING"
            DB 10,13,"2. LENGTH OF STRING"
            DB 10,13,"3. REVERSE OF STRING"
            DB 10,13,"4. CHECKING PALINDROME"
            DB 10,13,"5. EXIT " 
            DB 10,13,"ENTER YOUR CHOICE: $" 
 
        MSG1 DB 10,13,"ACCEPT STRING FROM USER: $"
        MSG2 DB 10,13,"LENGTH OF THE STRING IS : $"
        MSG3 DB 10,13,"REVERSE OF THE STRING IS : $"
        MSG4 DB 10,13,"STRING IS A PALINDROME $"
        MSG5 DB 10,13,"STRING IS NOT A PALINDROME$"

.CODE
	MOV AX, @DATA
	MOV DS, AX
START: 
	DISP MSG

	MOV AH,01H
	INT 21H
	CMP AL, 31H
	JE ACCEPT1
	CMP AL, 32H
	JE LENGTH1
	CMP AL, 33H
	JE REVERSE1
	CMP AL, 34H
	JE PALINDROME
	CMP AL, 35H
	JE EXIT
ACCEPT1:
        CALL ACCEPT
        JMP START         
LENGTH1:
        CALL LEN
        JMP START
REVERSE1:
        CALL REV
        JMP START
PALINDROME:
        CALL PAL
        JMP START  
EXIT:
        MOV AH, 4CH
        INT 21H  

ACCEPT PROC NEAR
	DISP MSG1
	MOV AH,0AH
	LEA DX, STR1
	INT 21H
	LEA SI, STR1
        INC SI                  ; POINT TO FIRST ELEMENT OF STRING
        MOV BL,[SI]             ; GET LENTH OF STRING IN BL
	RET
ACCEPT ENDP

LEN PROC NEAR
	DISP MSG2
	MOV CH,02H
	MOV CL,04H
UP:
        ROL BL, CL
	MOV DL, BL
	AND DL, 0FH
	CMP DL, 09H
	JBE LOOP1
	ADD DL, 07H
LOOP1: ADD DL, 30H
	MOV AH,02H
	INT 21H
	DEC CH
	JNZ UP
	RET
ENDP

REV PROC NEAR
	DISP MSG3
	LEA SI, STR1
	INC SI
	MOV BL, [SI]
	MOV BH, 00H
        ADD SI, BX              ;POINT TO LAST CHARACTER
UP1: 
        MOV DL, [SI]            ;
	MOV AH,02H
	INT 21H
	DEC SI
	DEC BL
	JNZ UP1
	RET
ENDP

PAL PROC NEAR
	LEA SI , STR1
	INC SI
	MOV BL, [SI]
	MOV BH, 00H
        ADD SI, BX              ;POINTS TO LAST CHARACTER
        SHR BL, 1               ;MAKE COUNT HALF
        LEA DI, STR1+2          ;POINT TO FIRST CHARACTER
UPP:
        MOV AL, [SI]
	MOV AH, [DI]
	CMP AL, AH
	JZ NEXT1
        DISP MSG5                ; MISSMATCH NOT PALINDORME
        JMP EXIT1                ; RET
NEXT1:
        DEC SI                   
	INC DI
        DEC BL                   ; DECREMENT COUNTR
	JNZ  UPP
	DISP MSG4
EXIT1:
        RET
ENDP

END


