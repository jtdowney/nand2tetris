class ThisTermNode
  def emit(writer, symbols)
    writer.write_push(:pointer, 0)
  end
end
