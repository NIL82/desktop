.MODEL SMALL
.STACK 100

PRINT1 MACRO STR
        MOV AH, 09H
        LEA DX, STR
        INT 21H
ENDM

.DATA
        ARRAY DB  10H,20H,30H,40H,50H
        CNT   DB  05H
        MSG1 DB "ARRAY IS $"
        MSG2 DB 10,13,"ARRAY ADDITION: $"
        MSG3 DB " $"
        SUM DW 00H
.CODE
        MOV AX, @DATA
        MOV DS, AX
        LEA SI, ARRAY

        PRINT1 MSG1

UP2:
        PRINT1 MSG3
        MOV CL, 04H
        MOV CH, 02H
        MOV BL, [SI]
UP1:    ROL BL, CL
        MOV DL, BL
        AND DL, 0FH
        CMP DL, 09H
        JBE DOWN2
        ADD DL, 07H
DOWN2:
        ADD DL, 30H
        MOV AH, 02H
        INT 21H
        DEC CH
        JNZ UP1
        INC SI
        DEC CNT
        JNZ UP2
;-----------------------------------------------------------------------
        LEA SI, ARRAY
        MOV CNT, 05H
LOOP1:
        MOV BL, [SI]
        MOV BH, 00H
        ADD SUM, BX
        INC SI
        DEC CNT
        JNZ LOOP1
;----------------------------------------------------------------
        PRINT1 MSG2
        MOV CL, 04H
        MOV CH, 04H
        MOV BX, SUM
UP:
        ROL BX, CL
        MOV DL, BL
        AND DL, 0FH
        CMP DL, 09H
        JBE DOWN
        ADD DL, 07H
DOWN:
        ADD DL, 30H
        MOV AH, 02H
        INT 21H
        DEC CH
        JNZ UP
;----------------------------------------------------------------------
        MOV AH, 4CH
        INT 21H
END




          
