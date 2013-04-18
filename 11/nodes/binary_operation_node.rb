class BinaryOperationTermNode < Struct.new(:operator, :left, :right)
  def emit(writer, symbols)
    left.emit(writer, symbols)
    right.emit(writer, symbols)

    case operator
    when '&'
      writer.write_arithmetic(:and)
    when '|'
      writer.write_arithmetic(:or)
    when '+'
      writer.write_arithmetic(:add)
    when '-'
      writer.write_arithmetic(:sub)
    when '*'
      writer.write_call('Math.multiply', 2)
    when '/'
      writer.write_call('Math.divide', 2)
    when '='
      writer.write_arithmetic(:eq)
    when '<'
      writer.write_arithmetic(:lt)
    when '>'
      writer.write_arithmetic(:gt)
    else
      raise "Unknown operation #{operator}"
    end
  end
end
