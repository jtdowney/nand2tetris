#!/usr/bin/env ruby

require 'bundler'
Bundler.require

class Token < Struct.new(:kind, :text)
  Kinds = [:keyword, :symbol, :identifier, :string_constant, :integer_constant]

  Kinds.each do |token_kind|
    define_method("#{token_kind}?") do
      token_kind == kind
    end
  end

  def to_xml
    builder = Builder::XmlMarkup.new
    builder.tag!(kind, " #{text} ")
    builder.target!
  end
end

class Tokenizer
  include Enumerable

  Keywords = [
    'class', 'method', 'function', 'constructor', 'int', 'boolean', 'char',
    'void', 'var', 'static', 'field', 'let', 'do', 'if', 'else', 'while',
    'return', 'true', 'false', 'null', 'this'
  ]

  Symbols = [
    "{", "}", "(", ")", "[", "]", ".", ",", ";", "+", "-", "*", "/", "&",
    "|", "<", ">", "=", "~", "\""
  ]

  def initialize(text)
    text.gsub!(/\/\/.*$/, '')
    text.gsub!(/\/\*.*?\*\//m, '')
    quotes = text.scan(/"(.*)"/).flatten

    Symbols.each do |symbol|
      text.gsub!(symbol, " #{symbol} ")
    end

    lines = text.split("\n")
    lines.map!(&:strip)
    lines.reject!(&:empty?)

    words = lines.flat_map { |line| line.split(' ') }
    @tokens = _tokenize(words, quotes)
    @index = 0
  end

  def each
    @tokens.each do |token|
      yield token
    end
  end

  def has_more_tokens?
    @index < (@tokens.length - 1)
  end

  def next
    if has_more_tokens?
      @index += 1
    end
  end

  def prev
    if @index > 0
      @index -= 1
    end
  end

  def token
    @tokens[@index]
  end

  def _tokenize(words, quotes)
    i = 0
    j = 0
    tokens = []
    while i < words.length
      token = words[i]
      i = i + 1

      if token == '"'
        while words[i] != '"'
          i += 1
        end

        tokens << Token.new(:string_constant, quotes[j])
        i = i + 1
        j = j + 1
      elsif Keywords.include?(token)
        tokens << Token.new(:keyword, token)
      elsif Symbols.include?(token)
        tokens << Token.new(:symbol, token)
      else
        if token =~ /\A\d+\z/
          tokens << Token.new(:integer_constant, token)
        else
          tokens << Token.new(:identifier, token)
        end
      end
    end
    tokens
  end
end

if $PROGRAM_NAME == __FILE__
  require 'cgi'

  if ARGV.length != 1
    abort("Must provide jack file to tokenize")
  end

  infile = ARGV[0]
  text = File.read(infile)
  tokenizer = Tokenizer.new(text)
  builder = Builder::XmlMarkup.new(:target => STDOUT, :indent => 2)
  builder.tokens do
    tokenizer.each do |token|
      builder << token.to_xml
      builder << "\n"
    end
  end
end
