class ClassVariableDeclarationNode < Struct.new(:name, :type, :kind)
  def to_xml
    builder = Builder::XmlMarkup.new
    builder.classVarDec do |xml|
      xml.keyword(kind)
      if Tokenizer::Keywords.include?(type)
        xml.keyword(type)
      else
        xml.identifier(type)
      end
      xml.identifier(name)
      xml.symbol(';')
    end
    builder.target!
  end
end
