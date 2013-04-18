class SubCommand
  def initialize(id, filename, current_function)
  end

  def emit
    <<-ASM
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
ASM
  end
end
