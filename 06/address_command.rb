class AddressCommand
  def initialize(command)
    @constant = command.slice(1..-1)
  end

  def emit
    @constant.to_i.to_s(2).rjust(16, '0')
  end
end
