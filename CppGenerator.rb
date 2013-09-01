# coding: utf-8
require 'erb'
require './type_map.rb'
require './CppHelper.rb'
require './CppIntValueGenerator.rb'
require './CppStringValueGenerator.rb'

module Codegen

  class CppGenerator
  
  	include CppHelper
    include TypeResolver
  
    def initialize
  
    end
  
    def generate(name, yaml)
      @name = name
      env = yaml['env']
      sections = yaml['sections']
      filename = 'Ini.cpp.erb'
      erb = ERB.new(File.read(filename), nil, '-')
      erb.filename = filename
      erb.result(binding)
    end

    def section_to_s(section)
      name = @name
      string_type = TYPE_MAP['string']
      unless @section_erb
        filename = '_Section.cpp.erb'
        @section_erb = ERB.new(File.read(filename), nil, '-')
      end
      @section_erb.result(binding)
    end

    def class_to_s(sections)
      name = @name
      string_type = TYPE_MAP['string']
      unless @class_erb
        filename ='_Class.cpp.erb'
        @class_erb = ERB.new(File.read(filename), nil, '-')
      end
      @class_erb.result(binding)
    end

    def section_initializer_to_s(section)
      values = section['values']
      source = ""
      if values and values.length > 0
        source = ":"
        values.each_with_index do |value,i|
          source << "\n_#{value['attr']}()" + (i + 1 < values.length ? "," : "")  
        end
      end
      source
    end

    def value_load_to_s(value)
      gen = get_value_generator(value['type'])
      gen.generate_load(value)
    end

    def value_save_to_s(value)
      gen = get_value_generator(value['type'])
      gen.generate_save(value)
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
