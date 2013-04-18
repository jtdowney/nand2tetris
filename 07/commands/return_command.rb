class ReturnCommand
  def initialize(id, filename, current_function)
  end

  def emit
    <<-ASM
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
ASM
  end
end
