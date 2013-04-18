class FalseTermNode
  def emit(writer, symbols)
    writer.write_push(:constant, 0)
  end
end
