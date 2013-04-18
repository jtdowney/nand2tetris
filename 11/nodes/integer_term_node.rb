class IntegerTermNode < Struct.new(:value)
  def emit(writer, symbols)
    writer.write_push(:constant, value)
  end
end
