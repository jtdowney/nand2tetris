class VariableTermNode < Struct.new(:name, :index_expression)
  def emit(writer, symbols)
    symbol = symbols.lookup(name)
    unless symbol.present?
      raise "Unable to find symbol #{name}"
    end

    kind = symbol.kind
    if symbol.kind == :field
      kind = :this
    end

    writer.write_push(kind, symbol.index)

    if index_expression
      index_expression.emit(writer, symbols)
      writer.write_arithmetic(:add)
      writer.write_pop(:pointer, 1)
      writer.write_push(:that, 0)
    end
  end
end
