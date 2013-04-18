// push constant 17
@17
D=A
@SP
A=M
M=D
@SP
M=M+1

// push constant 17
@17
D=A
@SP
A=M
M=D
@SP
M=M+1

// eq
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
@TRUE2
D;JEQ
@SP
A=M
M=0
@END2
0;JMP

(TRUE2)
@SP
A=M
M=-1

(END2)
