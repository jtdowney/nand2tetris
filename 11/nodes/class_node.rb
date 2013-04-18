class ClassNode < Struct.new(:name, :class_vars, :subroutines)
  def emit(writer, symbols)
    symbols.current_class = name

    class_vars.each do |class_var|
      class_var.emit(writer, symbols)
    end

    subroutines.each do |subroutine|
      subroutine.emit(writer, symbols, self)
    end
  end

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
