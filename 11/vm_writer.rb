class VMWriter
  def initialize(symbols)
    @symbols = symbols
    @commands = []
  end

  def write_function(name, locals_count)
    @commands << "function #{name} #{locals_count}"
  end

  def write_call(name, argument_count)
    @commands << "call #{name} #{argument_count}"
  end

  def write_push(segment, index)
    @commands << "push #{segment} #{index}"
  end

  def write_pop(segment, index)
    @commands << "pop #{segment} #{index}"
  end

  def write_arithmetic(operation)
    @commands << operation
  end

  def write_label(label)
    @commands << "label #{label}"
  end

  def write_if(label)
    @commands << "if-goto #{label}"
  end

  def write_goto(label)
    @commands << "goto #{label}"
  end

  def write_return
    @commands << "return"
  end

  def save(file)
    File.open(file, 'w') do |f|
      text = @commands.join("\n")
      f.write(text)
    end
  end
end
