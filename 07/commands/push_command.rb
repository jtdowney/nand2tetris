class PushCommand
  Segments = {
    'local' => 'LCL',
    'argument' => 'ARG',
    'this' => 'THIS',
    'that' => 'THAT',
  }

  def initialize(id, filename, current_function, segment, index)
    @segment = segment
    @filename = filename
    @index = index
  end

  def emit
    case @segment
    when 'pointer'
      pointer = (@index == '0') ? 'THIS' : 'THAT'
      <<-ASM
// push #{@segment} #{@index}
@#{pointer}
D=M
@SP
A=M
M=D
@SP
M=M+1
ASM
    when 'static'
      <<-ASM
// push #{@segment} #{@index}
@#{@filename}.#{@index}
D=M
@SP
A=M
M=D
@SP
M=M+1
ASM
    when 'temp'
      offset = 5 + @index.to_i
      <<-ASM
// push #{@segment} #{@index}
@#{offset}
D=M
@SP
A=M
M=D
@SP
M=M+1
ASM
    when 'constant'
      <<-ASM
// push #{@segment} #{@index}
@#{@index}
D=A
@SP
A=M
M=D
@SP
M=M+1
ASM
    else
      <<-ASM
// push #{@segment} #{@index}
@#{@index}
D=A
@#{Segments[@segment]}
A=M
D=D+A
A=D
D=M
@SP
A=M
M=D
@SP
M=M+1
ASM
    end
  end
end
