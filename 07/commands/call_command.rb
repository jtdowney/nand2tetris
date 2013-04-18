class CallCommand
  def initialize(id, filename, current_function, function, argument_count)
    @id = id
    @function = function
    @argument_count = argument_count.to_i
  end

  def emit
    <<-ASM
// call #{@function} #{@argument_count}
@RETURN#{@id}
D=A
@SP
A=M
M=D // push return-address
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D // push LCL
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D // push ARG
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D // push THIS
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D // push THAT
@SP
M=M+1
D=M
@#{@argument_count}
D=D-A
@5
D=D-A
@ARG
M=D // ARG = SP-n-5
@SP
D=M
@LCL
M=D // LCL = SP
@#{@function}
0;JMP // goto #{@function}
(RETURN#{@id})
ASM
  end
end
