# coding: utf-8
require './IniSectionGenerator.rb'
require './IniCommentGenerator.rb'

module Codegen

  class IniGenerator
  
    include IniCommentGenerator
  
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
