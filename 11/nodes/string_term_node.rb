class StringTermNode < Struct.new(:value)
  def emit(writer, symbols)
    writer.write_push(:constant, value.length)
    writer.write_call('String.new', 1)
    value.each_codepoint do |char|
      writer.write_push(:constant, char)
      writer.write_call('String.appendChar', 2)
    end
  end
end
