.MODEL SMALL

DISP MACRO MSG
        MOV AH, 09H
        LEA DX, MSG
        INT 21H
ENDM

.DATA
        MSG1 DB 10,13,"ENTER THE SIZE OF ARRAY: $"
        MSG2 DB 10,13,"ENTER ARRAY ELEMENTS $" 
        MSG3 DB 10,"ADDITION : "
        MSG4 DB " $"
        ARRAY DB 50H DUP('0')
        SUM DW 00H
        ASIZE DB ?
        CNT1 DB ?

.CODE
        MOV AX, @DATA
        MOV DS, AX
;----------------------ACCEPT SINGLE DIGIT ARRAY SIZE------------------------
        DISP MSG1

        MOV AH, 01H
        INT 21H

        CMP AL, 39H
        JBE DOWN1
        SUB AL, 07H
DOWN1:
        SUB AL, 30H
        MOV ASIZE, AL
        MOV CNT1, AL
;---------------------ACCEPT 2 DIGIT ARRAY ELEMETS---------------------------
        DISP MSG2

        LEA SI, ARRAY
UP1:
        DISP MSG4

        MOV CL, 04H
        MOV AH, 01H
        INT 21H

        CMP AL, 39H
        JBE DOWN2
        SUB AL, 07H
DOWN2:
        SUB AL, 30H
        MOV BL, AL
        ROL BL, CL

        MOV AH, 01H
        INT 21H

        CMP AL, 39H
        JBE DOWN3
        SUB AL, 07H
DOWN3:
        SUB AL, 30H
        ADD BL, AL
        MOV [SI], BL
        INC SI
        DEC CNT1
        JNZ UP1
;----------------------PERFORM ADDITION-------------------------------------
UP2:
        MOV BL, [SI]
        MOV BH, 00H
        ADD SUM, BX
        INC SI
        DEC ASIZE
        JNZ UP2
;----------------------PRINT SUM--------------------------------------------

        MOV BX, SUM
        MOV CL, 04H
        MOV CH, 04H

        DISP MSG3

UP3:
        ROL BX, CL
        MOV DL, BL
        AND DL, 0FH
        CMP DL, 09H
        JBE DOWN4
        ADD DL, 07H
DOWN4:
        ADD DL, 30H
        MOV AH, 02H
        INT 21H

        DEC CH
        JNZ UP3

        MOV AH, 4CH
        INT 21H
END


        



