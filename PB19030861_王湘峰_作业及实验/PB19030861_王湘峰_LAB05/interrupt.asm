        .ORIG x800
        ; (1) Initialize interrupt vector table.
        LD R0, VEC
        LD R1, ISR
        STR R1, R0, #0

        ; (2) Set bit 14 of KBSR.
        LDI R0, KBSR
        LD R1, MASK
        NOT R1, R1
        AND R0, R0, R1
        NOT R1, R1
        ADD R0, R0, R1
        STI R0, KBSR

        ; (3) Set up system stack to enter user space.
        LD R0, PSR
        ADD R6, R6, #-1
        STR R0, R6, #0
        LD R0, PC
        ADD R6, R6, #-1
        STR R0, R6, #0
        ; Enter user space.
        RTI
        
VEC     .FILL x0180
ISR     .FILL x1000
KBSR    .FILL xFE00
MASK    .FILL x4000
PSR     .FILL x8002
PC      .FILL x3000
        .END

        .ORIG x3000
        ; *** Begin user program code here ***
LOOP    LEA R0 ICS2020
        TRAP x22
        JSR DELAY
        BRnzp LOOP

        
DELAY   ST R1, SaveR1
        LD R1, COUNT
        REP ADD R1, R1, #-1
        BRp REP
        LD R1, SaveR1
        RET
ICS2020 .STRINGZ "ICS2020 "
COUNT   .FILL x7FFF
SaveR1  .BLKW #1
        ; *** End user program code here ***
         .END


        .ORIG x1000
        ; *** Begin interrupt service routine code here ***
        ST R0, SaveR0
        ST R1, SAVE1
        ST R2  SAVER2
        LD R0 NEWLINE
        OUT
        GETC
        OUT
        ADD R1 R0 #0
        LD R2 ASCII
        ADD R1 R2 R1
        BRn ERROR;输入的字符ASCII码值小于48
        ADD R1 R1 #-9
        BRp ERROR;输入的字符ASCII码值大于57
        LEA R0 YES
        PUTS
        LD R0 NEWLINE
        OUT
        LD R0, SaveR0
        LD R1, SAVE1
        LD R2 SAVER2
        RTI
        
ERROR   LEA R0 NO
        PUTS
        LD R0 NEWLINE
        OUT
        LD R0, SaveR0
        LD R1, SAVE1
        LD R2 SAVER2
        RTI
SaveR0  .BLKW #1    
SAVE1  .BLKW #1 
SAVER2  .BLKW #1
NEWLINE .FILL x000A
ASCII   .FILL xFFD0
YES     .STRINGZ " is a decimal digit"
NO      .STRINGZ " is not a decimal digit"
        ; *** End interrupt service routine code here ***
        .END