class ReturnStatementNode < Struct.new(:value_expression)
  def to_xml
    builder = Builder::XmlMarkup.new
    builder.returnStatement do |xml|
      xml.keyword('return')
      xml.symbol(';')
    end
    builder.target!
  end
end
