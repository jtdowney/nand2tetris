class SubroutineBodyNode < Struct.new(:vars, :statements)
  def to_xml
    builder = Builder::XmlMarkup.new
    builder.subroutineBody do |xml|
      xml.symbol('{')
      vars.each do |var|
        xml << var.to_xml
      end
      xml.statements do |statements_xml|
        statements.each do |statement|
          statements_xml << statement.to_xml
        end
      end
      xml.symbol('}')
    end
    builder.target!
  end
end
