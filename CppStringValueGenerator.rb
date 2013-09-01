require './CppHelper.rb'

module Codegen

  class CppStringValueGenerator

    include CppHelper
    
    def generate_load(value_def)
      method_name = "loadString"
      type = value_def['type']
      if type =~ /(.*)_list/
        type = $1
        method_name << "List"
      end

      default_value = ""
      default_value = value_def['default'] if value_def.has_key? 'default'
  
      source = <<STR
_#{value_def['attr']} = IniHelper::#{method_name}(iniPath, section, #{textize value_def['attr'].chomp}, #{textize default_value});
STR
      source
    end

    def generate_save(value_def)

    end
  end
end
