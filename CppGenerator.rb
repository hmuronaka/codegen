# coding: utf-8
require './CppSectionGenerator.rb'
require './CppCommentGenerator.rb'
require './type_map.rb'
require './Indent.rb'

module Codegen

  class CppGenerator
  
    include TypeResolver
  
    def initialize
  
    end
  
    def generate(name, yaml)
      env = yaml['env']
      source = ""
      yaml['sections'].each do |section|
        generator = CppSectionGenerator.new(env)
        source << generator.generate(section)
        source << "\n"
      end
  
      string_type = get_string_type 
      source << gen_constructor(name)
      source << "\n"
      source << gen_method(name, yaml['sections'], "load")
      source << "\n"
      source << gen_method(name, yaml['sections'], "save")
      source << "\n"
      
    end
  
    def gen_constructor(name)
      source =<<STR
#{name}::#{name}{}
#{name}::~#{name}{}

STR
      source
    end
  
    def gen_method(name, sections, method_name)
      string_type = TYPE_MAP['string']
      source =<<STR
void #{name}::#{method_name}(const #{string_type}& iniPath) {
STR
      source.indent "" do |src|
        sections.each do |section|
          attr = section['section']
        src.indent <<STR
_#{attr}.#{method_name}(iniPath, "#{attr}");
STR
        end
      end
      source << "}"
    end
  
  end
  
end
