# coding: utf-8
require 'erb'
require './IniListValueGenerator.rb'
require './IniStringValueGenerator.rb'
require './IniCommentGenerator.rb'
require './IniIntValueGenerator.rb'

module Codegen

  class IniGenerator

    include IniCommentGenerator
  
    def initialize
  
    end
  
    def generate(yaml)
      @env = yaml['env']

      filename = "Ini.erb"
      erb = ERB.new(File.read(filename), nil, "-")
      sections = yaml['sections']
      env = yaml['env']
      erb.result(binding)
    end

    def section_to_s(section)
      unless @section_erb
        filename = '_Section.ini.erb'
        @section_erb = ERB.new(File.read(filename), nil, "-")
        @section_erb.filename = filename
      end
      @section_erb.result(binding)
    end

    def value_to_s(value)
      gen = new_generator(value['type'])
      gen.generate(value)
    end

    def new_generator(type)
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
