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

// function Class1.set 0
(Class1.set)

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

// pop static 0
@SP
M=M-1
A=M
D=M
@Class1.0
M=D

// push argument 1
@1
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

// pop static 1
@SP
M=M-1
A=M
D=M
@Class1.1
M=D

// push constant 0
@0
D=A
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

// function Class1.get 0
(Class1.get)

// push static 0
@Class1.0
D=M
@SP
A=M
M=D
@SP
M=M+1

// push static 1
@Class1.1
D=M
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

// function Class2.set 0
(Class2.set)

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

// pop static 0
@SP
M=M-1
A=M
D=M
@Class2.0
M=D

// push argument 1
@1
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

// pop static 1
@SP
M=M-1
A=M
D=M
@Class2.1
M=D

// push constant 0
@0
D=A
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

// function Class2.get 0
(Class2.get)

// push static 0
@Class2.0
D=M
@SP
A=M
M=D
@SP
M=M+1

// push static 1
@Class2.1
D=M
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

// push constant 6
@6
D=A
@SP
A=M
M=D
@SP
M=M+1

// push constant 8
@8
D=A
@SP
A=M
M=D
@SP
M=M+1

// call Class1.set 2
@RETURN28
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
@2
D=D-A
@5
D=D-A
@ARG
M=D // ARG = SP-n-5
@SP
D=M
@LCL
M=D // LCL = SP
@Class1.set
0;JMP // goto Class1.set
(RETURN28)

// pop temp 0
@SP
M=M-1
A=M
D=M
@5
M=D

// push constant 23
@23
D=A
@SP
A=M
M=D
@SP
M=M+1

// push constant 15
@15
D=A
@SP
A=M
M=D
@SP
M=M+1

// call Class2.set 2
@RETURN32
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
@2
D=D-A
@5
D=D-A
@ARG
M=D // ARG = SP-n-5
@SP
D=M
@LCL
M=D // LCL = SP
@Class2.set
0;JMP // goto Class2.set
(RETURN32)

// pop temp 0
@SP
M=M-1
A=M
D=M
@5
M=D

// call Class1.get 0
@RETURN34
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
@Class1.get
0;JMP // goto Class1.get
(RETURN34)

// call Class2.get 0
@RETURN35
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
@Class2.get
0;JMP // goto Class2.get
(RETURN35)

// label WHILE
(Sys.init$WHILE)

// goto WHILE
@Sys.init$WHILE
0;JMP
