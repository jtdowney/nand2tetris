#!/usr/bin/env ruby

require 'securerandom'
require 'pathname'
require 'bundler'
Bundler.require

require 'active_support/inflector'

$LOAD_PATH.unshift(File.expand_path('..', __FILE__))

require 'analyzer'
require 'symbol_table'
require 'vm_writer'

ARGV.each do |infile|
  unless File.exist?(infile)
    raise "Could not find file #{infile}"
  end

  path = Pathname.new(infile)
  outfile = path.basename('.jack').to_s + '.vm'
  symbols = SymbolTable.new
  writer = VMWriter.new(symbols)

  text = File.read(infile)
  analyzer = Analyzer.new(text)
  class_node = analyzer.compile_class
  require 'pp'
  pp class_node
  class_node.emit(writer, symbols)

  writer.save(outfile)
end
