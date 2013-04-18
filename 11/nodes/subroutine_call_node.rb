class SubroutineCallNode < Struct.new(:target, :name, :arguments)
  def emit(writer, symbols)
    argument_count = arguments.length
    call = "#{target}.#{name}"

    if target.nil?
      call = "#{symbols.current_class}.#{name}"
      argument_count += 1
      writer.write_push(:pointer, 0)
    else
      symbol = symbols.lookup(target)
      if symbol.present?
        call = "#{symbol.type}.#{name}"
        argument_count += 1

        kind = symbol.kind
        if symbol.kind == :field
          kind = :this
        end

        writer.write_push(kind, symbol.index)
      end
    end

    arguments.each do |argument|
      argument.emit(writer, symbols)
    end

    writer.write_call(call, argument_count)
  end
end
