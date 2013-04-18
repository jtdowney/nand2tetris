class ParameterNode < Struct.new(:name, :type)
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
