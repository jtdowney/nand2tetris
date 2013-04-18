class IfStatementNode < Struct.new(:value_expression, :statements, :else_statements)
  def emit(writer, symbols)
    name = "if_#{SecureRandom.hex}"
    body_name = "#{name}_body"
    else_name = "#{name}_else"
    end_name = "#{name}_end"

    value_expression.emit(writer, symbols)
    writer.write_if(body_name)
    writer.write_goto(else_name)
    writer.write_label(body_name)

    statements.each do |statement|
      statement.emit(writer, symbols)
    end

    writer.write_goto(end_name)
    writer.write_label(else_name)

    else_statements.each do |statement|
      statement.emit(writer, symbols)
    end

    writer.write_label(end_name)
  end
end
