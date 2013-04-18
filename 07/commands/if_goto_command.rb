class IfGotoCommand
  def initialize(id, filename, current_function, label)
    @current_function = current_function
    @label = label
  end

  def emit
    <<-ASM
// if-goto #{@label}
@SP
M=M-1
A=M
D=M
@#{@current_function}$#{@label}
D;JNE
ASM
  end
end
