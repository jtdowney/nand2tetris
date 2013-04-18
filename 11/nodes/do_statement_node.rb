require 'forwardable'

class DoStatementNode < Struct.new(:call)
  extend Forwardable

  def emit(writer, symbols)
    call.emit(writer, symbols)
    writer.write_pop(:temp, 0)
  end

  def to_xml
    builder = Builder::XmlMarkup.new
    builder.doStatement do |xml|
      xml.keyword('do')
      xml << call.to_xml
      xml.symbol(';')
    end
    builder.target!
  end
end
