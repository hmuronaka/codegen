class String

  attr_accessor :indent_str

  def indent(text, &block)
    @depth = 0 unless @depth
    @indent_str = "\t" unless @indent_str

    real_indent_str = @indent_str * @depth 
   # @depth.times do 
   #   real_indent_str << @indent_str
   # end
    text = text.gsub(/^/, "#{real_indent_str}")
    self << text
    if block
      @depth += 1
      block.call self
      @depth -= 1
    end
    self
  end

end
