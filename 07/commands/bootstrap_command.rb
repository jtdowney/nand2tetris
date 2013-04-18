class BootstrapCommand
  def initialize
  end

  def emit
    output = <<-ASM
// bootstrap
@256
D=A
@SP
M=D

ASM
    call = CallCommand.new("bootstrap", "bootstrap", "bootstrap", "Sys.init", 0)
    output += call.emit
    output
  end
end
