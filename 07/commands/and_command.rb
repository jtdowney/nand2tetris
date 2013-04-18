class AndCommand
  def initialize(id, filename, current_function)
  end

  def emit
    <<-ASM
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
ASM
  end
end
