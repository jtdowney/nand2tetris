#!/usr/bin/env ruby

require 'pathname'
require 'active_support/inflector'

$LOAD_PATH.unshift(File.expand_path('..', __FILE__))

require 'commands/bootstrap_command.rb'

if ARGV.length != 1
  $stderr.puts "Must provide a VM file to translate"
  exit(1)
end

all_commands = []
all_commands << BootstrapCommand.new

id = 0
current_function = ''
infiles = Dir.glob("*.vm")
infiles.each do |infile|
  path = Pathname.new(infile)
  basename = path.basename('.vm')

  lines = File.readlines(infile)
  lines.map! { |line| line.gsub(/(\/\/.*)$/, '') }
  lines.map!(&:strip)
  lines.reject!(&:empty?)
  commands = lines.map do |line|
    parts = line.split(' ')
    command = parts.shift.gsub('-', '_')
    filename = "#{command}_command"
    klass = filename.camelize
    unless Kernel.const_defined?(klass)
      require "commands/#{filename}"
    end

    id += 1
    instance = klass.constantize.new(id, basename, current_function, *parts)
    if instance.is_a?(FunctionCommand)
      current_function = instance.function_name
    end
    instance
  end.compact
  all_commands.concat(commands)
end

outfile = ARGV[0] + '.asm'

parts = all_commands.map(&:emit)
output = parts.join("\n")
puts output
File.open(outfile, "w") do |file|
  file.write(output)
end
