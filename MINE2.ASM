.MODEL SMALL
.STACK
.DATA
        MSG1 DB 10,13,"MENU"
             DB 10,13,"1.BCD TO HEX"
             DB 10,13,"2.HEX TO BCD"
             DB 10,13,"3.EXIT $"
        MSG2 DB 10,13,"ENTER THE NUMBER$"
        MSG3 DB 10,13,"ERROR$"
        MSG4 DB 10,13,"CONVERTED BCD TO HEX IS $"
        MSG5 DB 10,13,"CONVERTED HEX TO BCD IS $"

        NUM DB 00H
        SUM DW 00H
        RESULT DB 5 DUP(0)

DISP MACRO MSG
        MOV AH, 09H
        LEA DX, MSG
        INT 21H
ENDM


.CODE
        MOV AX, @DATA
        MOV DS, AX

START:
        DISP MSG1
        MOV AH, 01H
        INT 21H

        CMP AL, 31H
        JE BCDTOHEX
        CMP AL, 32H
        JE HEXTOBCD
        CMP AL, 33H
        JE EXIT
EXIT:
        MOV AH, 4CH
        INT 21H

BCDTOHEX:
        CALL ASCII2BCD
        CALL BCD2HEX
        JMP START
HEXTOBCD:
        CALL ASCII2HEX
        CALL HEX2BCD
        JMP START

ASCII2BCD PROC NEAR
        DISP MSG2
        MOV SUM, 0000H
NEXT_D:
        MOV AH, 01H
        INT 21H

        CMP AL, 0DH
        JE QUIT
        CMP AL, 30H
        JB ERROR
        CMP AL, 39H
        JA ERROR

        AND AL, 0FH

        MOV NUM, AL
        MOV AX, SUM
        MOV BX, 0AH
        MUL BX
        ADD AL, NUM
        JNC CARRY
        INC AH
CARRY:
        MOV SUM, AX
        JMP NEXT_D
ERROR:
        DISP MSG3
QUIT:
        RET

ASCII2BCD ENDP

BCD2HEX PROC NEAR
        DISP MSG4
        MOV SI, 00H
        MOV AX, SUM
        MOV BX, 10H
CONT:
        MOV DX, 00H
        DIV BX
        MOV RESULT[SI], DL
        INC SI
        CMP AX, 00H
        JNE CONT

NEXT_H:
        DEC SI
        MOV DL, RESULT[SI]
        CALL DISP_NO
        CMP SI, 00H
        JNE NEXT_H
        RET
BCD2HEX ENDP

DISP_NO PROC NEAR
        ADD DL, 30H
        CMP DL, 39H
        JBE NEXT
        ADD DL, 07H
NEXT:
        MOV AH, 02H
        INT 21H
        RET
DISP_NO ENDP

ASCII2HEX PROC NEAR
        DISP MSG2
        MOV SUM, 0000H
NEXT_D1:
        MOV AH, 01H
        INT 21H

        CMP AL, 0DH
        JE QUIT1
        CMP AL, 30H
        JB ERROR1
        CMP AL, 39H
        JBE SUB1
        CMP AL, 41H
        JB ERROR1
        CMP AL, 46H
        JA ERROR1
        SUB AL, 07H
SUB1:
        SUB AL, 30H

        AND AL, 0FH

        MOV NUM, AL
        MOV AX, SUM
        MOV BX, 10H
        MUL BX
        ADD AL, NUM
        JNC CARRY1
        INC AH
CARRY1:
        MOV SUM, AX
        JMP NEXT_D1
ERROR1:
        DISP MSG3
QUIT1:
        RET

ASCII2HEX ENDP

HEX2BCD PROC NEAR
        DISP MSG5
        MOV SI, 00H
        MOV AX, SUM
        MOV BX, 0AH
CONT1:
        MOV DX, 00H
        DIV BX
        MOV RESULT[SI], DL
        INC SI
        CMP AX, 00H
        JNE CONT1
NEXT_H1:
        DEC SI
        MOV DL, RESULT[SI]
        CALL DISP_NO1
        CMP SI, 00H
        JNE NEXT_H1
        RET
HEX2BCD ENDP

DISP_NO1 PROC NEAR
        ADD DL, 30H
        MOV AH, 02H
        INT 21H
        RET
DISP_NO1 ENDP

END


             

