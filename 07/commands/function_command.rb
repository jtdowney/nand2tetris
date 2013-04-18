class FunctionCommand
  def initialize(id, filename, current_function, function, local_count)
    @function = function
    @local_count = local_count.to_i
  end

  def function_name
    @function
  end

  def emit
    output = <<-ASM
// function #{@function} #{@local_count}
(#{@function})
ASM
    @local_count.times do
      output += <<-ASM
@SP
A=M
M=0
@SP
M=M+1
ASM
    end

    output
  end
end
