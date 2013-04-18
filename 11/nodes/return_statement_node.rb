class ReturnStatementNode < Struct.new(:value_expression)
  def emit(writer, symbols)
    if value_expression.nil?
      writer.write_push(:constant, 0)
    else
      value_expression.emit(writer, symbols)
    end

    writer.write_return
  end

  def to_xml
    builder = Builder::XmlMarkup.new
    builder.returnStatement do |xml|
      xml.keyword('return')
      xml.symbol(';')
    end
    builder.target!
  end
end
