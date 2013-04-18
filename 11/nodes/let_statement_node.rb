class LetStatementNode < Struct.new(:name, :index_expression, :value_expression)
  def emit(writer, symbols)
    symbol = symbols.lookup(name)
    unless symbol.present?
      raise "Unable to find symbol #{name} in #{symbols.inspect}"
    end

    kind = symbol.kind
    if symbol.kind == :field
      kind = :this
    end

    value_expression.emit(writer, symbols)

    if index_expression.nil?
      segment = kind
      index = symbol.index
    else
      writer.write_push(kind, symbol.index)
      index_expression.emit(writer, symbols)
      writer.write_arithmetic(:add)
      writer.write_pop(:pointer, 1)

      segment = :that
      index = 0
    end

    writer.write_pop(segment, index)
  end
end
