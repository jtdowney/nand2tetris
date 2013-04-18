require 'forwardable'

class ExpressionNode < Struct.new(:term)
  extend Forwardable

  def_delegator :term, :emit
end
