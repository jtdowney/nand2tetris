class LetStatementNode < Struct.new(:name, :index_expression, :value_expression)
  def to_xml
    builder = Builder::XmlMarkup.new
    builder.letStatement do |xml|
      xml.keyword('let')
      xml.identifier(name)
      xml.symbol('=')
      xml.expression do |expression_xml|
        expression_xml.term do |term_xml|
          term_xml.identifier(value_expression)
        end
      end
      xml.symbol(';')
    end
    builder.target!
  end
end
