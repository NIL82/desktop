
org 0000H
  
        mov a,#38H                             ; //function set
	lcall write_lcd_cmd
        mov a,#08H                             ; //display off
	lcall write_lcd_cmd
        mov a,#01H                             ; //display clear
	lcall write_lcd_cmd
        mov a,#06H                             ; //entry mode set
	lcall write_lcd_cmd
        mov a,#0fH                             ; //display on
	lcall write_lcd_cmd
        mov a,#80H                             ; //set address counter value
	lcall write_lcd_cmd
	                                              
	mov a,#'H'				 
	lcall write_lcd_data
	mov a,#'E'				 
	lcall write_lcd_data
	mov a,#'L'				 
	lcall write_lcd_data
	mov a,#'L'				 
	lcall write_lcd_data
	mov a,#'O'
        lcall write_lcd_data

here:   sjmp here

write_lcd_cmd:
	mov P0,A		;Write the value on port P0
        lcall Delay
        SETB p3.3               ; Set pin p3.3 i.e. enable LCD
        lcall Delay
        MOV P3,#00              ; clear the control signals
	ret

write_lcd_data:
	mov P0,A		;Write the value on port P0
        lcall Delay
        SETB p3.2               ; keep RS = 1 for writing data on LCD
        SETB p3.3
        lcall Delay
        MOV P3,#00              ; clear the control signals
	ret

Delay:
        mov r4,#0ffH      
        mov r5,#0ffH 
        loop:
	djnz r5,loop
	djnz r4,loop
	ret

	
	



