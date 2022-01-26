.globl main

.rodata
  TITLE:   .string "\n-------The Game of Nim-------\n"
  SHOW_A:  .string "\n\nROW A: "
  SHOW_Ao: .string "ooo"
  SHOW_B:  .string "\nROW B: "
  SHOW_Bo: .string "ooooo"
  SHOW_C:  .string "\nROW C: "
  SHOW_Co: .string "oooooooo"
  SHOW_1:  .string "\nPlayer 1, choose a row and number of rocks:"
  SHOW_2:  .string "\nPlayer 2, choose a row and number of rocks:"
  WIN_1:   .string "\n\nPlayer 1 Wins.\n"
  WIN_2:   .string "\n\nPlayer 2 Wins.\n"
  INVALID: .string "\nInvalid move. Try again."
  OVER:    .string "\n-------Game Over-------\n"

.text
main:
INIT:    
        andi    t6,t6,0        #Player 1 is 0,Player 2 is 1.
        andi    x5,x5,0
        andi    x6,x6,0
        andi    x7,x7,0
        li      x2,3            #Rocks in A
        li      x3,5            #Rocks in B
        li      x4,8            #Rocks in C
        li      t3,'A'
        li      t4,'B'
        li      t5,'C'
        li      a0,4
        la      a1,TITLE
        ecall
#
LOOP:    
        bne     x2,x0,PRINT
        bne     x3,x0,PRINT
        beq     x4,x0,CHECK_3     #Game over and someone wins.
#       
PRINT:
        li      a0,4
        la      a1,SHOW_A
        ecall
        la      a1,SHOW_Ao
        add     a1,a1,x5
        ecall
        li      a0,4
        la      a1,SHOW_B
        ecall
        la      a1,SHOW_Bo
        add     a1,a1,x6
        ecall
        li      a0,4
        la      a1,SHOW_C
        ecall
        la      a1,SHOW_Co
        add     a1,a1,x7
        ecall
#      
CHECK_1:                          #Check the player.
        bne     t6,x0,PL2
PL1:    
        li      a0,4 
        la      a1,SHOW_1
        ecall
        j       INPUT
PL2:
        li      a0,4 
        la      a1,SHOW_2
        ecall
#        
INPUT:
        li      a0,12
        ecall
        mv      x8,a0             #row input
        li      a0,5
        ecall
        mv      x9,a0             #rocks input
CHECK_2:                          #Check the rows.
        beq     x8,t3,INPUTA
        beq     x8,t4,INPUTB
        beq     x8,t5,INPUTC
        j       INV               #Else invalid input
#
INPUTA:
        mv      s2,x2
        mv      s3,x5
        jal     CAL
        mv      x2,s2
        mv      x5,s3
        not     t6,t6             #Change the player.
        j       LOOP
#	
INPUTB:
        mv      s2,x3
        mv      s3,x6
        jal     CAL
        mv      x3,s2
        mv      x6,s3
        not     t6,t6             #Change the player.
        j       LOOP
#	
INPUTC:  
        mv      s2,x4
        mv      s3,x7
        jal     CAL
        mv      x4,s2
        mv      x7,s3
        not     t6,t6             #Change the player.
        j       LOOP
#
INV:     
        li      a0,4 
        la      a1,INVALID
        ecall
        j       CHECK_1
#
CHECK_3:	
        bne     t6,x0,P2WINS
P1WINS:  
        li      a0,4 
        la      a1,WIN_1
        ecall
        j       END
P2WINS:  
        li      a0,4 
        la      a1,WIN_2
        ecall
END:     
        li      a0,4 
        la      a1,OVER
        ecall          
        li      a0, 10             #Ends the program with status code 0
        ecall
#
CAL:
        blt     x9,x0,INV
        beq     x9,x0,INV          #If x9<=0,invalid
        sub     s2,s2,x9
        blt     s2,x0,INV
        add     s3,s3,x9
        ret