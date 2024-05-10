// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

//Note that I did not work on this code independently. I had alot of struggle starting this portion of the 
//project, and heavily relied on online resources for its completion. I followed along how another person
//completed the assignment and understood the process. This is why I included many comments through the 
//code to not only better my understanding, but to show that I actually understand what is going on. 

//R0: 16-bit integer. If -1, then program enters ON. If 0, then program enters OFF
//R1: Row counter. 
//R2: current position holder
//LOOP: Main loop where keyboard input is always being sensed
//ON: Loop for if Keyboard is pressed; for blackshading
//OFF: Loop for it Keyboard is NOT pressed; for whiteshading
//ACTION: Loop for keeping track of pixel location and filling/unfilling pixels
//INRCEM: Loop for incrementing each row of the SCREEN, which there are 255 of them

(LOOP)
    @KBD    //Keyboard register value, 16384 
    D=M     //sets D as Keyboard register value
    //If KBD>0, executes ON
    @ON
    D;JGT   
    //If KBD=0, executes OFF
    @OFF
    D;JEQ 

(ON)
    @R0
    //Setting M=-1 allows for setting 16 pixels black at a time
    M=-1    //-1 = 1111111111111111
    @ACTION 
    0;JMP

(OFF)
    @R0
    M=0
    @ACTION
    0;JMP

(ACTION)
//since one row is 512 bit and I can assign 16 bits at a time, i want an increment of 512*16=8192
    @8191   
    D=A 
    @R1 //setting increment counter to 8191
    M=D
    (INCREM)
        @R1     
        D=M     //setting D to be total number of iterations I need to do per row
        @R2
        M=D     //setting R2 to be total number of iterations I need to do per row
        @SCREEN 
        D=A    //getting D equaling to the register address of the SCREEN
        @R2
        M=M+D  //incremented by one row

        @R0
        D=M    //setting D= -1 or 0, which maps back to SCREEN
        @R2 
        A=M //memory mapping R0 to R2, in which points to SCREEN meory address
        M=D //changing the address of R2 to map to ON (-1) or OFF (0)

        //removing 1 row because 1 row has been filled or unfilled
        @R1
        D=M-1
        //resetting counter
        M=D
        //if still needs to go through rest of rows so loop until D=0
        @INCREM
        D;JGE
    @LOOP
    0;JMP
    
