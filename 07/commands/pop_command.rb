class PopCommand
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
// pop #{@segment} #{@index}
@SP
M=M-1
A=M
D=M
@#{pointer}
M=D
ASM
    when 'static'
      <<-ASM
// pop #{@segment} #{@index}
@SP
M=M-1
A=M
D=M
@#{@filename}.#{@index}
M=D
ASM
    when 'temp'
      offset = 5 + @index.to_i
      <<-ASM
// pop #{@segment} #{@index}
@SP
M=M-1
A=M
D=M
@#{offset}
M=D
ASM
    else
      <<-ASM
// pop #{@segment} #{@index}
@#{@index}
D=A
@#{Segments[@segment]}
A=M
D=D+A
@#{Segments[@segment]}
M=D
@SP
M=M-1
A=M
D=M
@#{Segments[@segment]}
A=M
M=D
@#{@index}
D=A
@#{Segments[@segment]}
A=M
D=A-D
@#{Segments[@segment]}
M=D
ASM
    end
  end
end
