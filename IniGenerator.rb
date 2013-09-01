# coding: utf-8
require './IniSectionGenerator.rb'

module Codegen

  class IniGenerator
  
    def initialize
  
    end
  
    def generate(yaml)
      env = yaml['env']
      source = ""
      yaml['sections'].each do |section|
        generator = IniSectionGenerator.new(env)
        source << generator.generate(section)
      end
      source
    end
  end
  
end
