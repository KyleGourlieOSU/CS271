// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
//
// This program only needs to handle arguments that satisfy
// R0 >= 0, R1 >= 0, and R0*R1 < 32768.

    @i      //i is the counter
    M=0     //setting counter initially to 0
    @R2     //R2 is where the product will be stored
    M=0     //setting product to be initially 0
(LOOP)
    @i      //accessing i
    D=M     //setting D equal to memory of i
    @R1     //accessing R1 
    D=D-M   //checking to see if i==R1 
    @END 
    D;JEQ   //if i==R1, then JUMP to END

    @R0     //accessing R0
    D=M     //setting D equal to memory of R0
    @R2     //accessing R2
    M=M+D   //repeated addition to represent multiplication

    @i      //accessing i
    M=M+1   //incrementing i by 1
    @LOOP   //starting the LOOP
    0;JMP   //JUMP to LOOP

(END)       //infinite loop
    @END
    0;JMP

    