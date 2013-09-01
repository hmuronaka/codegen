# coding: utf-8
require './type_map.rb'
require './Indent.rb'
require './CppHelper.rb'
require './HeaderListValueGenerator.rb'
require './HeaderValueGenerator.rb'
require 'erb'

module Codegen 

  class HeaderGenerator
  
    include CppHelper

    def initialize
  
    end
  
    def generate(name, yaml)
      @name = name
      source = ""

      env = yaml['env']
      sections = yaml['sections']
      string_type = TYPE_MAP['string']

      erb = ERB.new(File.read('Ini.h.erb'),nil,'-')
      erb.filename = 'Ini.h.erb'
      erb.result(binding)
    end

    def section_to_s(section)
      unless @section_erb 
        @section_erb = ERB.new(File.read('_Section.h.erb'), nil, '-')
        @section_erb.filename = '_Section.h.erb'
      end
      @section_erb.result(binding)
    end

    def class_to_s(sections)
      name = @name
      string_type = TYPE_MAP['string']
      unless @class_erb
        @class_erb = ERB.new(File.read('_Class.h.erb'), nil, '-')
        @class_erb.filename = '_Class.h.erb'
      end
      @class_erb.result(binding)
    end

    def value_to_s(value)
      gen = get_value_generator(value['type'])
      gen.generate(value) if gen
    end

    def value_method_to_s(value)
      gen = get_value_generator(value['type'])
      gen.generate_method(value) if gen
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

