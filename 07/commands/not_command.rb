class NotCommand
  def initialize(id, filename, current_function)
  end

  def emit
    <<-ASM
// not
@SP
M=M-1
A=M
M=!M
@SP
M=M+1
ASM
  end
end
