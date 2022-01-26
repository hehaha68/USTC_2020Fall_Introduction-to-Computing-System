            .ORIG   x3000
            LD      R0,START
BEG         LDR     R2,R0,#1
            ADD     R3,R2,#0
            ADD     R1,R0,#0
;            
SORT        LDR     R1,R1,#0
            BRz    THEN2
            LDR     R2,R1,#1
            NOT     R4,R2
            ADD     R4,R4,#1
            ADD     R6,R3,R4
            BRn     THEN1
            JSR     SWAP
THEN1       BRnzp   SORT
THEN2       STR     R3,R0,#1
            LDR     R0,R0,#0
            BRnp    BEG
            HALT
;            
SWAP        STR     R3,R1,#1
            ADD     R3,R2,#0
            RET
START       .FILL   x3100
            .END