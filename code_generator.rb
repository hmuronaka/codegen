# coding: utf-8
require 'yaml'
require 'pp'
require './IniGenerator.rb'
require './HeaderGenerator.rb'
require './CppGenerator.rb'

module Codegen

  def self.code_gen(args)
  
    option = {
      command: ARGV[0],
      in_file: ARGV[1]
    }
  
    if option[:command] == "yml2ini"
      yml2ini option
    elsif option[:command] == "yml2h"
      option[:ini_name] = ARGV[2]
      yml2header option
    elsif option[:command] == "yml2cpp"
      option[:ini_name] = ARGV[2]
      yml2cpp option
    end
  
  end
  
  
  def self.yml2ini(option)
    yaml = YAML.load_file option[:in_file]
  
    # for debug.
    #pp yaml
    
  #   yaml.each do |section|
  #     parseSection section
  #     puts ""
  #   end
    
    gen = IniGenerator.new()
    puts gen.generate(yaml)
  
  end
  
  def self.yml2header(option)
    yaml = YAML.load_file option[:in_file]
    gen = HeaderGenerator.new()
    puts gen.generate(option[:ini_name], yaml)
  end
  
  def self.yml2cpp(option)
    yaml = YAML.load_file option[:in_file]
    gen = CppGenerator.new()
    puts gen.generate(option[:ini_name], yaml)
  end
  
end

Codegen::code_gen(ARGV)
