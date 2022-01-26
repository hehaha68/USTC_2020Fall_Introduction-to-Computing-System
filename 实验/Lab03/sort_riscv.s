.globl main

.text
main:
	LI    	x1,168     #start
BEG:       
 	LW	x3,4(x1)
	MV 	x4,x3
	MV 	x2,x1     
SORT:	
	LW	x2,0(x2)
	BEQ	x2,x7,THEN2
	LW	x3,4(x2)
	BGE	x3,x4,THEN1
SWAP:		
	SW	x4,4(x2)
	MV	x4,x3
THEN1:		
	J	SORT
THEN2:
	SW	x4,4(x1)
	LW	x1,0(x1)
	BNE	x1,x7,BEG
        LI      a0, 10
        ECALL
