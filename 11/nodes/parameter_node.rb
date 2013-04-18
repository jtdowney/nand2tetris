class ParameterNode < Struct.new(:name, :type)
  def emit(writer, symbols)
    symbols.define_argument(name, type)
  end

  def to_xml
    builder = Builder::XmlMarkup.new
    if Tokenizer::Keywords.include?(type)
      builder.keyword(type)
    else
      builder.identifier(type)
    end

    builder.identifier(name)
    builder.target!
  end
end
