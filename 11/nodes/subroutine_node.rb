class SubroutineNode < Struct.new(:name, :kind, :return_type, :parameters, :body)
  def emit(writer, symbols, class_node)
    if kind == 'method'
      symbols.start_instance_subroutine
    else
      symbols.start_subroutine
    end

    parameters.each do |parameter|
      parameter.emit(writer, symbols)
    end

    writer.write_function("#{class_node.name}.#{name}", body.vars.length)

    case kind
    when 'constructor'
      field_count = class_node.class_vars.select { |var| var.kind.to_sym == :field }.count
      writer.write_push(:constant, field_count)
      writer.write_call('Memory.alloc', 1)
      writer.write_pop(:pointer, 0)
    when 'method'
      writer.write_push(:argument, 0)
      writer.write_pop(:pointer, 0)
    end

    body.emit(writer, symbols)
  end

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
