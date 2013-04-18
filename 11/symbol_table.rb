require 'ostruct'

class SymbolTable
  Kinds = [:local, :argument, :field, :static]

  attr_accessor :current_class

  def initialize
    @statics = []
    @fields = []
    start_subroutine
  end

  def lookup(name)
    Kinds.each do |kind|
      table = instance_variable_get("@#{kind.to_s.pluralize}")
      index = table.index { |entry| entry[:name] == name }

      if index.nil?
        next
      end

      entry = table[index]
      return OpenStruct.new(:present? => true, :index => index, :kind => kind, :type => entry[:type])
    end

    OpenStruct.new(:present? => false)
  end

  def start_subroutine
    @locals = []
    @arguments = []
  end

  def start_instance_subroutine
    start_subroutine
    @arguments << {}
  end

  Kinds.each do |kind|
    define_method("define_#{kind}") do |name, type|
      table = instance_variable_get("@#{kind.to_s.pluralize}")
      entry = table.find { |entry| entry[:name] == name }
      if entry
        raise "Variable #{name} is already defined"
      else
        table << {:name => name, :type => type}
      end
    end
  end
end
