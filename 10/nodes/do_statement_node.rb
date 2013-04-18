class DoStatementNode < Struct.new(:call)
  def to_xml
    builder = Builder::XmlMarkup.new
    builder.doStatement do |xml|
      xml.keyword('do')
      xml << call.to_xml
      xml.symbol(';')
    end
    builder.target!
  end
end
