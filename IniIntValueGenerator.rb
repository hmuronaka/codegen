require './IniValueGenerator.rb'

module Codegen

  class IniIntValueGenerator < IniValueGenerator
  
    def generate(value_def)
      comment = generate_comment(value_def['comment'])
      result = <<STR
#{comment}
#{value_def['attr']}=
STR
      result.chomp
    end
  
  end
  
end
