class GotoCommand
  def initialize(id, filename, current_function, label)
    @current_function = current_function
    @label = label
  end

  def emit
    <<-ASM
// goto #{@label}
@#{@current_function}$#{@label}
0;JMP
ASM
  end
end

