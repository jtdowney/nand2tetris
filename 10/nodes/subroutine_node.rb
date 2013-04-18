class SubroutineNode < Struct.new(:name, :kind, :return_type, :parameters, :body)
  def to_xml
    builder = Builder::XmlMarkup.new
    builder.subroutineDec do |xml|
      xml.keyword(kind)
      if Tokenizer::Keywords.include?(return_type)
        xml.keyword(return_type)
      else
        xml.identifier(return_type)
      end
      xml.identifier(name)
      xml.symbol('(')
      xml.parameterList do |parameter_list_xml|
        parameters.each_with_index do |parameter, i|
          parameter_list_xml << parameter.to_xml
          if i != parameters.length - 1
            parameter_list_xml.symbol(',')
          end
        end
      end
      xml.symbol(')')
      xml << body.to_xml
    end
    builder.target!
  end
end
