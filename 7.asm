 
Sample Program  
A) Block transfer internal RAM to internal RAM memory:

Org 0000h		//initialize the memory to 0000h
mov r0,#15h		//moves immediate data 15h in r0		
mov r1,#25h		//moves immediate data 25h in r1
mov r3,#05h		//moves immediate data 05h in r3
up1:		//label named up1
            mov a,@r0		// move contents of r0 to accumulator
            mov a@r1,a		//move contents of accumulator to register r1
            inc r0		//increment r0 register by 1
            inc r1		//increment r1 register by 1
            djnz r3,up1		//decrement register r3 and jump if not zero to label up1

B) Block transfer external RAM to internal RAM memory:

Org 0000h		//initialize the memory to 0000h
mov dptr,#400h		//point pointer to value at 400h
mov r0,#30h			//load register r0
mov r2,#05h			//load counter with 5
back:				//label named back
clr a			//clear accumulator
movx a,@dptr	//load accumulator
mov @r0,a		//load register r0
inc dptr		//point to next location
inc r0			//increment value in register r0
          djnz r2,back		//decrement register r2 and jump if not zero to label back

 C) Block transfer internal ROM to internal RAM memory:
Org 0000h			//initialize the memory to 0000h
mov dptr,#0010h		//point pointer to value at 0010h
mov r0,#45h			//load register r0
mov r2,#05h			//load counter with 5
back:				//label named back
clr a			//clear accumulator
movc a,@a+dptr	//load accumulator
mov @r0,a		//load register r0
inc dptr		//point to next location
inc r0			//increment value in register r0
djnz r2,back		//decrement register r2 and jump if not zero to label back
