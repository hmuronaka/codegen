# coding: utf-8
require './CppHelper.rb'
require './HeaderListValueGenerator.rb'
require './HeaderValueGenerator.rb'
require './Indent.rb'

module Codegen

  class HeaderSectionGenerator
  
    include TypeResolver
    include CppHelper
  
    def initialize(env)
      @env = env
    end
  
    def generate(section)
      values = section['values']
      comment = commentize (section['comment'])
      source = "" 
      source.indent( <<STR
#{comment}
class #{section['section'].chomp} : public ISection {
private:
STR
                   ) do | src|
        # メンバー変数の生成           
        values.each do |value_def|
          value_generator = get_value_generator value_def['type'].chomp
          src.indent value_generator.generate(value_def)
        end
      end

      source.indent("public:\n") do |src|
        values.each do |value_def|
          value_generator = get_value_generator value_def['type'].chomp
          src.indent(value_generator.generate_method(value_def))
        end

        string_type = TYPE_MAP['string']
        src.indent <<STR
virtual void load(const #{string_type}& iniPath, const #{string_type}& section);

virtual void save(const ##{string_type}& iniPath, const #{string_type}& section);

STR
      end
      source.indent "};"
      source
    end
  
    def get_value_generator(type)
      if type =~ /(.*)_list$/
        return HeaderListValueGenerator.new(@env, $1)
      elsif type == "int" or
            type == "string"
        return HeaderValueGenerator.new(@env)
      end
    end
  end
  
end
