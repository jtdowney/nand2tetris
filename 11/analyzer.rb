#!/usr/bin/env ruby

require 'bundler'
Bundler.require

$LOAD_PATH.unshift(File.expand_path('..', __FILE__))

require 'tokenizer'

Dir.glob(File.expand_path('../nodes/*', __FILE__)) do |file|
  require file
end

class Analyzer
  ClassVarDecKeywords = ['static', 'field']
  StatementOpenings = ['let', 'if', 'while', 'do', 'return']
  SubroutineDecKeywords = ['constructor', 'function', 'method']
  Types = ['int', 'char', 'boolean']

  Operators = ['+', '-', '*', '/', '&', '|', '<', '>', '=']
  UnaryOperators = ['-', '~']

  def initialize(text)
    @tokenizer = Tokenizer.new(text)
  end

  def compile_class
    _expect_next_keyword('class')
    class_name = _expect_next_identifier
    _expect_next_symbol('{')

    class_vars = []
    while @tokenizer.has_more_tokens? && ClassVarDecKeywords.include?(@tokenizer.token.text)
      class_vars.concat(compile_class_var_dec)
    end

    subroutines = []
    while @tokenizer.has_more_tokens? && SubroutineDecKeywords.include?(@tokenizer.token.text)
      subroutines << compile_subroutine_dec
    end

    _expect_next_symbol('}')

    ClassNode.new(class_name, class_vars, subroutines)
  end

  def compile_class_var_dec
    kind = _expect_next(:kind => :keyword)
    type = _expect_next

    names = []
    while @tokenizer.token.text != ';'
      if @tokenizer.token.text == ','
        @tokenizer.next
      end

      names << _expect_next_identifier
    end

    _expect_next_symbol(';')

    names.map { |name| ClassVariableDeclarationNode.new(name, type, kind) }
  end

  def compile_subroutine_dec
    kind = _expect_next(:kind => :keyword)
    return_type = _expect_next
    name = _expect_next_identifier
    _expect_next_symbol('(')
    paramters = compile_parameter_list
    _expect_next_symbol(')')
    body = compile_subroutine_body

    SubroutineNode.new(name, kind, return_type, paramters, body)
  end

  def compile_parameter_list
    parameters = []
    while @tokenizer.token.text != ')'
      if @tokenizer.token.text == ','
        @tokenizer.next
      end

      type = _expect_next
      name = _expect_next_identifier

      parameters << ParameterNode.new(name, type)
    end

    parameters
  end

  def compile_subroutine_body
    _expect_next_symbol('{')

    vars = []
    statements = []
    while @tokenizer.token.text != '}'
      while @tokenizer.token.text == 'var'
        vars.concat(compile_var_dec)
      end

      statements = compile_statements
    end

    _expect_next_symbol('}')

    SubroutineBodyNode.new(vars, statements)
  end

  def compile_var_dec
    _expect_next_keyword('var')
    type = _expect_next

    names = []
    while @tokenizer.token.text != ';'
      if @tokenizer.token.text == ','
        @tokenizer.next
      end

      names << _expect_next_identifier
    end

    _expect_next_symbol(';')

    names.map { |name| VariableDeclarationNode.new(name, type) }
  end

  def compile_statements
    statements = []
    while StatementOpenings.include?(@tokenizer.token.text)
      statements << send("compile_#{@tokenizer.token.text}_statement")
    end

    statements
  end

  def compile_let_statement
    _expect_next_keyword('let')
    name = _expect_next_identifier
    index_expression = nil
    if @tokenizer.token.text == '['
      _expect_next_symbol('[')
      index_expression = compile_expression
      _expect_next_symbol(']')
    end
    _expect_next_symbol('=')
    value_expression = compile_expression
    _expect_next_symbol(';')

    LetStatementNode.new(name, index_expression, value_expression)
  end

  def compile_if_statement
    _expect_next_keyword('if')
    _expect_next_symbol('(')
    value_expression = compile_expression
    _expect_next_symbol(')')
    _expect_next_symbol('{')
    statements = compile_statements
    _expect_next_symbol('}')
    else_statements = []
    if @tokenizer.token.text == 'else'
      _expect_next_keyword('else')
      _expect_next_symbol('{')
      else_statements = compile_statements
      _expect_next_symbol('}')
    end

    IfStatementNode.new(value_expression, statements, else_statements)
  end

  def compile_while_statement
    _expect_next_keyword('while')
    _expect_next_symbol('(')
    value_expression = compile_expression
    _expect_next_symbol(')')
    _expect_next_symbol('{')
    statements = compile_statements
    _expect_next_symbol('}')

    WhileStatementNode.new(value_expression, statements)
  end

  def compile_do_statement
    _expect_next_keyword('do')
    call = compile_subroutine_call
    _expect_next_symbol(';')

    DoStatementNode.new(call)
  end

  def compile_return_statement
    _expect_next_keyword('return')
    if @tokenizer.token.text != ';'
      value_expression = compile_expression
    end

    _expect_next_symbol(';')

    ReturnStatementNode.new(value_expression)
  end

  def compile_expression
    term = compile_term
    while @tokenizer.token.symbol? && Operators.include?(@tokenizer.token.text)
      operator = _expect_next(:kind => :symbol)
      right = compile_term
      term = BinaryOperationTermNode.new(operator, term, right)
    end

    ExpressionNode.new(term)
  end

  def compile_expression_list
    expressions = []
    while @tokenizer.token.text != ')'
      if @tokenizer.token.text == ','
        _expect_next_symbol(',')
      end

      expressions << compile_expression
    end
    expressions
  end

  def compile_term
    if @tokenizer.token.integer_constant?
      IntegerTermNode.new(_expect_next)
    elsif @tokenizer.token.string_constant?
      StringTermNode.new(_expect_next)
    elsif @tokenizer.token.keyword?
      keyword = _expect_next(:kind => :keyword)
      case keyword
      when 'true'
        TrueTermNode.new
      when 'false'
        FalseTermNode.new
      when 'null'
        NullTermNode.new
      when 'this'
        ThisTermNode.new
      end
    elsif @tokenizer.token.identifier?
      name = _expect_next_identifier
      if @tokenizer.token.text == '['
        _expect_next_symbol('[')
        index_expression = compile_expression
        _expect_next_symbol(']')
        VariableTermNode.new(name, index_expression)
      elsif @tokenizer.token.text == '.' || @tokenizer.token.text == '('
        @tokenizer.prev
        compile_subroutine_call
      else
        VariableTermNode.new(name)
      end
    elsif @tokenizer.token.text == '('
      _expect_next_symbol('(')
      expression = compile_expression
      _expect_next_symbol(')')
      expression
    elsif UnaryOperators.include?(@tokenizer.token.text)
      operator = _expect_next(:kind => :symbol)
      term = compile_term
      UnaryOperationNode.new(operator, term)
    else
      raise "Unrecognize term #{@tokenizer.token}"
    end
  end

  def compile_subroutine_call
    target_or_name = _expect_next_identifier
    target = nil
    name = nil

    if @tokenizer.token.text == '.'
      target = target_or_name
      _expect_next_symbol('.')
      name = _expect_next_identifier
    else
      name = target_or_name
    end

    _expect_next_symbol('(')
    arguments = compile_expression_list
    _expect_next_symbol(')')

    SubroutineCallNode.new(target, name, arguments)
  end

  def _expect_next_keyword(keyword)
    _expect_next(:text => keyword, :kind => :keyword)
  end

  def _expect_next_identifier
    _expect_next(:kind => :identifier)
  end

  def _expect_next_symbol(symbol)
    _expect_next(:text => symbol, :kind => :symbol)
  end

  def _expect_next(options = {})
    if options.has_key?(:kind) && @tokenizer.token.kind != options[:kind]
      raise "Expected #{options[:kind]} got #{@tokenizer.token}"
    end

    if options.has_key?(:text) && @tokenizer.token.text != options[:text]
      raise "Expected #{options[:text]} got #{@tokenizer.token}"
    end

    text = @tokenizer.token.text
    @tokenizer.next

    text
  end
end

if $PROGRAM_NAME == __FILE__
  require 'cgi'

  if ARGV.length != 1
    abort("Must provide jack file to tokenize")
  end

  infile = ARGV[0]
  text = File.read(infile)

  analyzer = Analyzer.new(text)
  class_node = analyzer.compile_class

  require 'pp'
  pp class_node

  # builder = Builder::XmlMarkup.new(:target => STDOUT)
  # builder << class_node.to_xml
end
