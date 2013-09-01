#  coding: utf-8
require 'erb'
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

      filename = 'Section.ini.erb'
      erb = ERB.new(File.read(filename),nil, '-')
      erb.filename = filename
      erb.result(binding)
    end

    def valuelize(value)
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
