class WhileStatementNode < Struct.new(:value_expression, :statements)
  def emit(writer, symbols)
    name = "while_#{SecureRandom.hex}"
    loop_name = "#{name}_loop"
    end_name = "#{name}_end"

    writer.write_label(loop_name)
    value_expression.emit(writer, symbols)
    writer.write_arithmetic(:not)
    writer.write_if(end_name)

    statements.each do |statement|
      statement.emit(writer, symbols)
    end

    writer.write_goto(loop_name)
    writer.write_label(end_name)
  end
end
