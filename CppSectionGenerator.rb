# coding: utf-8
require './Indent.rb'
require './type_map.rb'
require './CppIntValueGenerator.rb'
require './CppStringValueGenerator.rb'


module Codegen

  class CppSectionGenerator
  
    def initialize(env)
      @env = env
    end
  
    def generate(section)
       source = ""
#      source = gen_constructor section
#      source << "\n"
#      source << gen_destructor(section)
#      source << "\n"
      source << gen_load(section)
    end
  
    def gen_constructor(section)
      name = section['section'].chomp
      values = section['values']
      source = <<STR
#{name}::#{name}() #{(values and values.length > 0) ? ":" : ""}
STR
      
      values = section['values']
      values.each_with_index do |value_def, i|
        source <<<<STR
#{value_def['attr']}()#{(i + 1) < values.length ?  "," : ""}
STR
      end
      source <<<<STR
{
}
STR
    end
  
    def gen_destructor(section)
      name = section['section'].chomp
      source = <<STR
#{name}::~#{name}
{
}
STR
    end
  
  
    def gen_load(section)
      string_type = TYPE_MAP['string']
      source = <<STR
void #{section['section']}::load(const #{string_type}& iniPath, const #{string_type}& section)
STR
  
      source.indent "{\n" do |src|
        values = section['values']
        values.each do |value_def|
          generator = get_value_generator(value_def['type'])
          if generator
            src.indent generator.generate(value_def) 
          else
            puts "nil" + value_def['type']
          end
        end
      end
      source.indent "}"
      source
    end
  
    def get_value_generator(type)
      if type =~ /string/
        return CppStringValueGenerator.new
      elsif type =~ /int/
        return CppIntValueGenerator.new
      end
    end
  end
end
