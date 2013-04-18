class ClassVariableDeclarationNode < Struct.new(:name, :type, :kind)
  def emit(writer, symbols)
    case kind.to_sym
    when :field
      symbols.define_field(name, type)
    when :static
      symbols.define_static(name, type)
    end
  end
end
