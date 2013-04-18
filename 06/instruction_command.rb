class InstructionCommand
  def initialize(command)
    @destination, @operation, @jump = _split_command(command)
  end

  def emit
    output = "111"
    case @operation
    when '0'
      output << '0101010'
    when '1'
      output << '0111111'
    when '-1'
      output << '0111010'
    when 'D'
      output << '0001100'
    when 'A'
      output << '0110000'
    when 'M'
      output << '1110000'
    when '!D'
      output << '0001101'
    when '!A'
      output << '0110001'
    when '!M'
      output << '1110001'
    when '-D'
      output << '0001111'
    when '-A'
      output << '0110011'
    when '-M'
      output << '1110011'
    when 'D+1'
      output << '0011111'
    when 'A+1'
      output << '0110111'
    when 'M+1'
      output << '1110111'
    when 'D-1'
      output << '0001110'
    when 'A-1'
      output << '0110010'
    when 'M-1'
      output << '1110010'
    when 'D+A'
      output << '0000010'
    when 'D+M'
      output << '1000010'
    when 'D-A'
      output << '0010011'
    when 'D-M'
      output << '1010011'
    when 'A-D'
      output << '0000111'
    when 'M-D'
      output << '1000111'
    when 'D&A'
      output << '0000000'
    when 'D&M'
      output << '1000000'
    when 'D|A'
      output << '0010101'
    when 'D|M'
      output << '1010101'
    end

    output << (@destination.include?('A') ? '1' : '0')
    output << (@destination.include?('D') ? '1' : '0')
    output << (@destination.include?('M') ? '1' : '0')

    case @jump
    when ''
      output << '000'
    when 'JGT'
      output << '001'
    when 'JEQ'
      output << '010'
    when 'JGE'
      output << '011'
    when 'JLT'
      output << '100'
    when 'JNE'
      output << '101'
    when 'JLE'
      output << '110'
    when 'JMP'
      output << '111'
    end

    output
  end

  def _split_command(command)
    destination = ''
    operation = ''
    jump = ''
    if command.include?('=')
      destination, operation = command.split('=')
    else
      operation = command
    end

    if operation.include?(';')
      operation, jump = operation.split(';')
    end

    [destination, operation, jump]
  end
end
