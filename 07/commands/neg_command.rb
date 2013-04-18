class NegCommand
  def initialize(id, filename, current_function)
  end

  def emit
    <<-ASM
// neg
@SP
M=M-1
A=M
M=-M
@SP
M=M+1
ASM
  end
end
