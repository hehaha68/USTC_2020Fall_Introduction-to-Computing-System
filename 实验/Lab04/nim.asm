        .ORIG x3000
INIT    AND     R1,R1,#0        ;Player 1 is 0,Player 2 is 1.
        LEA     R0,SHOW_A
        ADD     R0,R0,#12
        ST      R0,ADD_A
        LEA     R0,SHOW_B
        ADD     R0,R0,#13
        ST      R0,ADD_B
        LEA     R0,SHOW_C
        ADD     R0,R0,#15
        ADD     R0,R0,#1
        ST      R0,ADD_C
        LEA     R0,TITLE	
        PUTS
;        
LOOP    LD      R0,ROCKS_A
        BRnp    PRINT
        LD      R0,ROCKS_B
        BRnp    PRINT
        LD      R0,ROCKS_C
        BRz     CHECK_3         ;Game over and someone wins.
;        
PRINT   LEA     R0,SHOW_A
        PUTS
        LEA     R0,SHOW_B
        PUTS
        LEA     R0,SHOW_C
        PUTS
;        
CHECK_1 ADD     R1,R1,#0        ;Check the player.
        BRnp    PL2
PL1     LEA     R0,SHOW_1
        PUTS
        BR      INPUT
PL2     LEA     R0,SHOW_2
        PUTS
;        
INPUT   AND     R0,R0,#0
        GETC
        ST      R0,ROW
        OUT
        GETC
        ST      R0,ROCKS
        OUT
CHECK_2 LD      R3,A            ;Check the rows.
        LD      R4,ROW
        ADD     R3,R3,R4        ;Check if the row is A
        BRz     INPUTA
        LD      R3,B
        ADD     R3,R3,R4        ;Check if the row is B
        BRz     INPUTB
        LD      R3,C
        ADD     R3,R3,R4        ;Check if the row is B
        BRz     INPUTC
        BRnp    INV             ;Else invalid input
;
INPUTA  LD      R2,ROCKS_A
        LD      R3,ADD_A	
        JSR     CAL
        ST      R2,ROCKS_A
        ST      R3,ADD_A
        NOT     R1,R1           ;Change the player.
        BR      LOOP
;	
INPUTB  LD      R2,ROCKS_B
        LD      R3,ADD_B
        JSR     CAL
        ST      R2,ROCKS_B
        ST      R3,ADD_B
        NOT     R1,R1
        BR      LOOP
;	
INPUTC  LD      R2,ROCKS_C
        LD      R3,ADD_C
        JSR     CAL
        ST      R2,ROCKS_C
        ST      R3,ADD_C
        NOT     R1,R1
        BR      LOOP
;
INV     LEA     R0,INVALID      ;Invalid input
        PUTS
        BR      CHECK_1
;
CHECK_3	ADD     R1,R1,#0        ;Check the winner.
        BRnp    P2WINS
P1WINS  LEA     R0,WIN_1	
        PUTS
        BR      END
P2WINS  LEA     R0,WIN_2
        PUTS
END     LEA     R0,OVER	
        PUTS
        HALT                    ;Game Over.
;
CAL     LD      R4,ROCKS        ;CALCULATE
        LD      R5,N48
        ADD     R4,R4,R5        ;Char to int.
        BRnz    INV
        ADD     R2,R4,R2
        BRp     INV
        NOT     R4,R4
        ADD     R4,R4,#1        ;Negative number.
        ADD     R3,R3,R4
        AND     R5,R5,#0
        STR     R5,R3,#0
        RET
;
ROW     .FILL   x0000
ROCKS   .FILL   x0000
A	    .FILL   xFFBF       ;-65,A is 65 in decimal.
B	    .FILL   xFFBE       ;-66
C	    .FILL   xFFBD       ;-67
ROCKS_A .FILL   xFFFD       ;-3,Rocks in row A now.
ROCKS_B .FILL   xFFFB       ;-5
ROCKS_C .FILL   xFFF8       ;-8
N48     .FILL   xFFD0       ;-48
ADD_A   .FILL   x0000
ADD_B   .FILL   x0000
ADD_C   .FILL   x0000
TITLE   .STRINGZ "\n-------The Game of Nim-------"
SHOW_A  .STRINGZ "\n\nROW A: ooo"
SHOW_B  .STRINGZ "\nROW B: ooooo"
SHOW_C  .STRINGZ "\nROW C: oooooooo"
SHOW_1  .STRINGZ "\nPlayer 1, choose a row and number of rocks:"
SHOW_2  .STRINGZ "\nPlayer 2, choose a row and number of rocks:"
WIN_1   .STRINGZ "\n\nPlayer 1 Wins.\n"
WIN_2   .STRINGZ "\n\nPlayer 2 Wins.\n"
INVALID	.STRINGZ "\nInvalid move. Try again."
OVER    .STRINGZ "-------Game Over-------"
        .END