class VariableDeclarationNode < Struct.new(:name, :type)
  def to_xml
    builder = Builder::XmlMarkup.new
    builder.varDec do |xml|
      xml.keyword('var')
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
