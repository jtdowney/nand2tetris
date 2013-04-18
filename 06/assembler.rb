require 'pathname'

$LOAD_PATH.unshift('.')
require 'address_command'
require 'instruction_command'

symbols = {
  'SP' => '0',
  'LCL' => '1',
  'ARG' => '2',
  'THIS' => '3',
  'THAT' => '4',
  'R0' => '0',
  'R1' => '1',
  'R2' => '2',
  'R3' => '3',
  'R4' => '4',
  'R5' => '5',
  'R6' => '6',
  'R7' => '7',
  'R8' => '8',
  'R9' => '9',
  'R10' => '10',
  'R11' => '11',
  'R12' => '12',
  'R13' => '13',
  'R14' => '14',
  'R15' => '15',
  'SCREEN' => '16384',
  'KBD' => '24576',
}

label_match = /\((.*)\)/
symbol_match = /@([a-zA-Z$.:_][a-zA-Z0-9$.:_]*)/

if ARGV.length != 1
  $stderr.puts "Must provide an ASM file to assemble"
  exit(1)
end

infile = ARGV[0]
path = Pathname.new(infile)
basename = path.basename('.asm')
outfile = basename.to_s + '.hack'

lines = File.readlines(infile)
lines.map!(&:strip)
lines.reject!(&:empty?)
lines.reject! { |line| line =~ /^\/\// }

next_command = 0
lines.each do |line|
  if line =~ label_match
    symbols[$1] = next_command
  else
    next_command += 1
  end
end

next_symbol = 16
lines.each do |line|
  if line =~ symbol_match && !symbols.include?($1)
    symbols[$1] = next_symbol
    next_symbol += 1
  end
end

lines.map! do |line|
  if line =~ symbol_match
    "@#{symbols[$1]}"
  else
    line
  end
end

commands = lines.map do |line|
  if line =~ label_match
    next
  end

  if line.start_with?('@')
    AddressCommand.new(line)
  else
    InstructionCommand.new(line)
  end
end.compact

output = commands.map(&:emit).join("\r\n")
File.open(outfile, "w") do |file|
  file.write(output)
end
