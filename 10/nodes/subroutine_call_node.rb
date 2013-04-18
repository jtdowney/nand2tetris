class SubroutineCallNode < Struct.new(:target, :name, :arguments)
  def to_xml
    builder = Builder::XmlMarkup.new
    unless target.nil?
      builder.identifier(target)
      builder.symbol('.')
    end

    builder.identifier(name)
    builder.symbol('(')
    builder.expressionList
    builder.symbol(')')

    builder.target!
  end
end
