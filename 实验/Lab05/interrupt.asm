; Unfortunately we have not YET installed Windows or Linux on the LC-3,
; so we are going to have to write some operating system code to enable
; keyboard interrupts. The OS code does three things:
;
;    (1) Initializes the interrupt vector table with the starting
;        address of the interrupt service routine. The keyboard
;        interrupt vector is x80 and the interrupt vector table begins
;        at memory location x0100. The keyboard interrupt service routine
;        begins at x1000. Therefore, we must initialize memory location
;        x0180 with the value x1000.
;    (2) Sets bit 14 of the KBSR to enable interrupts.
;    (3) Pushes a PSR and PC to the system stack so that it can jump
;        to the user program at x3000 using an RTI instruction.

        .ORIG x800
        ; (1) Initialize interrupt vector table.
        LD  R0, VEC
        LD  R1, ISR
        STR R1, R0, #0

        ; (2) Set bit 14 of KBSR.
        LDI R0, KBSR
        LD  R1, MASK
        NOT R1, R1
        AND R0, R0, R1
        NOT R1, R1
        ADD R0, R0, R1
        STI R0, KBSR

        ; (3) Set up system stack to enter user space.
        LD  R0, PSR
        ADD R6, R6, #-1
        STR R0, R6, #0
        LD  R0, PC
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
        
        ST  R0, SaveR0
LOOP    LEA R0, LC
        PUTS
        JSR DELAY
        BR  LOOP
        LD  R0, SaveR0
        HALT
        
DELAY   ST  R1, SaveR1
        LD  R1, COUNT
REP     ADD R1, R1, #-1
        BRp REP
        LD  R1, SaveR1
        RET
;
COUNT   .FILL x7FFF
SaveR0  .FILL x0000
SaveR2  .FILL x0000
SaveR1  .BLKW #1
LC      .STRINGZ "ICS2020 "

        ; *** End user program code here ***
        .END

        .ORIG x1000
        ; *** Begin interrupt service routine code here ***
        
        ST  R0, Save_R0
        ST  R1, Save_R1
        GETC
        ADD R1, R0,#0
        LD  R0, N48;>=0
        ADD R0, R1, R0
        BRn ISN
        LD  R0, N57;<=9
        ADD R0, R1, R0
        BRp ISN
;
        LEA R0, SHOW_2
        STR R1, R0, #1
        LEA R0, SHOW_2
        BR  END
ISN     LEA R0, SHOW_1
        STR R1, R0, #1
        LEA R0, SHOW_1
END     PUTS
        LD  R0, Save_R0
        LD  R1, Save_R1
        RTI
        
Save_R0 .FILL   x0000
Save_R1 .FILL   x0000        
CHAR    .FILL   x0000
N48     .FILL   xFFD0;-48
N57     .FILL   xFFC7;-57
NEWLINE .FILL   x000A
SHOW_1  .STRINGZ "\n  is not a decimal digit.\n"
SHOW_2  .STRINGZ "\n  is a decimal digit.\n"

        ; *** End interrupt service routine code here ***
        .END
