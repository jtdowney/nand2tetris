class LabelCommand
  def initialize(id, filename, current_function, label)
    @current_function = current_function
    @label = label
  end

  def emit
    <<-ASM
// label #{@label}
(#{@current_function}$#{@label})
ASM
  end
end
