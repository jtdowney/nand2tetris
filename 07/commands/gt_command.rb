class GtCommand
  def initialize(id, filename, current_function)
    @id = id
  end

  def emit
    <<-ASM
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
@TRUE#{@id}
D;JGT
@SP
A=M
M=0
@END#{@id}
0;JMP

(TRUE#{@id})
@SP
A=M
M=-1

(END#{@id})
@SP
M=M+1
ASM
  end
end
