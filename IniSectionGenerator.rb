# coding: utf-8
require './IniCommentGenerator.rb'
require './IniIntValueGenerator.rb'
require './IniListValueGenerator.rb'
require './IniStringValueGenerator.rb'

module Codegen

  class IniSectionGenerator
  
    include IniCommentGenerator
  
    def initialize(env)
      @env = env
    end
  
    def generate(section)
      comment = generate_comment(section['comment'])
      source = comment
      source << "\n" if comment and comment.length > 0
      source << <<STR
[#{section['section'].chomp}]
STR
      values = section['values']
      values.each do |value_def|
        value_generator = get_value_generator value_def['type'].chomp
        source << value_generator.generate(value_def)
        source << "\n"
      end
      source
    end
  
    def get_value_generator(type)
      if type =~ /list$/
        return IniListValueGenerator.new(@env)
      elsif type == "int"
        return IniIntValueGenerator.new(@env)
      elsif type == "string"
        return IniStringValueGenerator.new(@env)
      end
    end
  end
  
end
