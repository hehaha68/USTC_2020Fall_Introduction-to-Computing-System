.globl main
.text
main:
    BGE	      x1,x2,GCD
    MV        x3,x1
    MV        x1,x2
    MV        x2,x3
GCD:	
    REM       x1,x1,x2
    BEQ       x1,x0,NEXT
    MV        x3,x1
    MV        x1,x2
    MV        x2,x3
    J         GCD
NEXT:	
    MV        x3,x1
    MV        x1,x2
    MV        x2,x3
    LI        a0, 10
    ECALL