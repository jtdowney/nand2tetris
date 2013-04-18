class ClassNode < Struct.new(:name, :class_vars, :subroutines)
  def to_xml
    builder = Builder::XmlMarkup.new(:indent => 2)
    builder.class do |xml|
      xml.keyword('class')
      xml.identifier(name)
      xml.symbol('{')
      class_vars.each do |class_var|
        xml << class_var.to_xml
      end

      subroutines.each do |subroutine|
        xml << subroutine.to_xml
      end

      xml.symbol('}')
    end
    builder.target!
  end
end
