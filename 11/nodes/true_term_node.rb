class TrueTermNode
  def emit(writer, symbols)
    writer.write_push(:constant, 0)
    writer.write_arithmetic(:not)
  end
end
