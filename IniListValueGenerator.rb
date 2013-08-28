require './IniValueGenerator.rb'

module Codegen

  class IniListValueGenerator < IniValueGenerator
  
    def generate(value_def)
      source = ""
      list_len = @env['list_len']
      source <<<<STR
#{value_def['attr'].chomp}_len=#{list_len}
#{value_def['attr'].chomp}_0=
STR
      source
    end
  end
  
end
