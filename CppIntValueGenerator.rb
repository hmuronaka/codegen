require './CppHelper.rb'

module Codegen

  class CppIntValueGenerator 
    include CppHelper

    def generate_load(value_def)
      type = value_def['type']
      method_name = "loadInt"
      if type =~ /(.*)_list/
        type = $1
        method_name << "List" 
      end

      default_value = 0
      default_value = value_def['default'] if value_def.has_key? 'default'
  
      source = <<STR
_#{value_def['attr']} = IniHelper::#{method_name}(iniPath, section, #{textize value_def['attr'].chomp}, #{default_value});
STR
      source
    end

    def generate_save(value_def)

    end
  end
  
end
