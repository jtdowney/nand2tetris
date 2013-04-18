// bootstrap
@256
D=A
@SP
M=D

// call Sys.init 0
@RETURNbootstrap
D=A
@SP
A=M
M=D // push return-address
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D // push LCL
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D // push ARG
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D // push THIS
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D // push THAT
@SP
M=M+1
D=M
@0
D=D-A
@5
D=D-A
@ARG
M=D // ARG = SP-n-5
@SP
D=M
@LCL
M=D // LCL = SP
@Sys.init
0;JMP // goto Sys.init
(RETURNbootstrap)

// function Main.fibonacci 0
(Main.fibonacci)

// push argument 0
@0
D=A
@ARG
A=M
D=D+A
A=D
D=M
@SP
A=M
M=D
@SP
M=M+1

// push constant 2
@2
D=A
@SP
A=M
M=D
@SP
M=M+1

// lt
@SP
A=M
A=A-1
A=A-1
D=M
A=A+1
D=D-M
@SP
M=M-1
M=M-1
@TRUE4
D;JLT
@SP
A=M
M=0
@END4
0;JMP

(TRUE4)
@SP
A=M
M=-1

(END4)
@SP
M=M+1

// if-goto IF_TRUE
@SP
M=M-1
A=M
D=M
@Main.fibonacci$IF_TRUE
D;JNE

// goto IF_FALSE
@Main.fibonacci$IF_FALSE
0;JMP

// label IF_TRUE
(Main.fibonacci$IF_TRUE)

// push argument 0
@0
D=A
@ARG
A=M
D=D+A
A=D
D=M
@SP
A=M
M=D
@SP
M=M+1

// return
@LCL
D=M
@frame
M=D // FRAME = LCL
@5
D=D-A
A=D
D=M
@ret
M=D // RET = *(FRAME-5)
@SP
M=M-1
A=M
D=M
@ARG
A=M
M=D // *ARG = pop
@ARG
D=M+1
@SP
M=D // SP = ARG+1
@frame
D=M
@1
D=D-A
A=D
D=M
@THAT
M=D // THAT = *(FRAME-1)
@frame
D=M
@2
D=D-A
A=D
D=M
@THIS
M=D // THIS = *(FRAME-2)
@frame
D=M
@3
D=D-A
A=D
D=M
@ARG
M=D // ARG = *(FRAME-3)
@frame
D=M
@4
D=D-A
A=D
D=M
@LCL
M=D // LCL = *(FRAME-4)
@ret
A=M
0;JMP

// label IF_FALSE
(Main.fibonacci$IF_FALSE)

// push argument 0
@0
D=A
@ARG
A=M
D=D+A
A=D
D=M
@SP
A=M
M=D
@SP
M=M+1

// push constant 2
@2
D=A
@SP
A=M
M=D
@SP
M=M+1

// sub
@SP
A=M
A=A-1
A=A-1
D=M
A=A+1
D=D-M
@SP
M=M-1
M=M-1
A=M
M=D
@SP
M=M+1

// call Main.fibonacci 1
@RETURN14
D=A
@SP
A=M
M=D // push return-address
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D // push LCL
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D // push ARG
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D // push THIS
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D // push THAT
@SP
M=M+1
D=M
@1
D=D-A
@5
D=D-A
@ARG
M=D // ARG = SP-n-5
@SP
D=M
@LCL
M=D // LCL = SP
@Main.fibonacci
0;JMP // goto Main.fibonacci
(RETURN14)

// push argument 0
@0
D=A
@ARG
A=M
D=D+A
A=D
D=M
@SP
A=M
M=D
@SP
M=M+1

// push constant 1
@1
D=A
@SP
A=M
M=D
@SP
M=M+1

// sub
@SP
A=M
A=A-1
A=A-1
D=M
A=A+1
D=D-M
@SP
M=M-1
M=M-1
A=M
M=D
@SP
M=M+1

// call Main.fibonacci 1
@RETURN18
D=A
@SP
A=M
M=D // push return-address
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D // push LCL
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D // push ARG
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D // push THIS
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D // push THAT
@SP
M=M+1
D=M
@1
D=D-A
@5
D=D-A
@ARG
M=D // ARG = SP-n-5
@SP
D=M
@LCL
M=D // LCL = SP
@Main.fibonacci
0;JMP // goto Main.fibonacci
(RETURN18)

// add
@SP
A=M
A=A-1
A=A-1
D=M
A=A+1
D=D+M
@SP
M=M-1
M=M-1
A=M
M=D
@SP
M=M+1

// return
@LCL
D=M
@frame
M=D // FRAME = LCL
@5
D=D-A
A=D
D=M
@ret
M=D // RET = *(FRAME-5)
@SP
M=M-1
A=M
D=M
@ARG
A=M
M=D // *ARG = pop
@ARG
D=M+1
@SP
M=D // SP = ARG+1
@frame
D=M
@1
D=D-A
A=D
D=M
@THAT
M=D // THAT = *(FRAME-1)
@frame
D=M
@2
D=D-A
A=D
D=M
@THIS
M=D // THIS = *(FRAME-2)
@frame
D=M
@3
D=D-A
A=D
D=M
@ARG
M=D // ARG = *(FRAME-3)
@frame
D=M
@4
D=D-A
A=D
D=M
@LCL
M=D // LCL = *(FRAME-4)
@ret
A=M
0;JMP

// function Sys.init 0
(Sys.init)

// push constant 4
@4
D=A
@SP
A=M
M=D
@SP
M=M+1

// call Main.fibonacci 1
@RETURN23
D=A
@SP
A=M
M=D // push return-address
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D // push LCL
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D // push ARG
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D // push THIS
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D // push THAT
@SP
M=M+1
D=M
@1
D=D-A
@5
D=D-A
@ARG
M=D // ARG = SP-n-5
@SP
D=M
@LCL
M=D // LCL = SP
@Main.fibonacci
0;JMP // goto Main.fibonacci
(RETURN23)

// label WHILE
(Sys.init$WHILE)

// goto WHILE
@Sys.init$WHILE
0;JMP
