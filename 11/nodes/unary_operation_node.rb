class UnaryOperationNode < Struct.new(:operator, :term)
  def emit(writer, symbols)
    term.emit(writer, symbols)

    case operator
    when '-'
      writer.write_arithmetic(:neg)
    when '~'
      writer.write_arithmetic(:not)
    else
      raise "Unknown operation #{operator}"
    end
  end
end
