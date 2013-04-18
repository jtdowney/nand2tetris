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
@SP
M=M+1

// push constant 892
@892
D=A
@SP
A=M
M=D
@SP
M=M+1

// push constant 891
@891
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
@TRUE5
D;JLT
@SP
A=M
M=0
@END5
0;JMP

(TRUE5)
@SP
A=M
M=-1

(END5)
@SP
M=M+1

// push constant 32767
@32767
D=A
@SP
A=M
M=D
@SP
M=M+1

// push constant 32766
@32766
D=A
@SP
A=M
M=D
@SP
M=M+1

// gt
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
@TRUE8
D;JGT
@SP
A=M
M=0
@END8
0;JMP

(TRUE8)
@SP
A=M
M=-1

(END8)
@SP
M=M+1

// push constant 56
@56
D=A
@SP
A=M
M=D
@SP
M=M+1

// push constant 31
@31
D=A
@SP
A=M
M=D
@SP
M=M+1

// push constant 53
@53
D=A
@SP
A=M
M=D
@SP
M=M+1

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

// push constant 112
@112
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

// neg
@SP
M=M-1
A=M
M=-M
@SP
M=M+1

// and
@SP
A=M
A=A-1
A=A-1
D=M
A=A+1
D=D&M
@SP
M=M-1
M=M-1
A=M
M=D
@SP
M=M+1

// push constant 82
@82
D=A
@SP
A=M
M=D
@SP
M=M+1

// or
@SP
A=M
A=A-1
A=A-1
D=M
A=A+1
D=D|M
@SP
M=M-1
M=M-1
A=M
M=D
@SP
M=M+1
