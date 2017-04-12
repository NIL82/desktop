ORG 0000H		;INITIALIZE THE MEMORY TO 0000H
MOV R0,#40H		;LOCATION FOR ARRAY
MOV R3,#10H		;SIZE OF ARRAY
MOV R6,#00H		;FOR CARRY
MOV A,#00H
BACK: 			;LABEL NAMED BACK
          ADD A,@R0	;ADD CONTENTS OF R0 WITH CONTENTS OF ACCUMULATOR	
          JNC DOWN	;JUMP IF NO CARRY TO LABEL DOWN
          INC R6	;INCREMENT R6 REGISTER BY 1
DOWN: 			;LABEL NAMED DOWN
          INC R0	;INCREMENT R0 REGISTER BY 1
          DJNZ R3, BACK	;DECREMENT REGISTER R3 AND JUMP IF NOT ZERO TO LABEL BACK
          MOV R7, A	;MOVE CONTENTS OF ACCUMULATOR TO R7

