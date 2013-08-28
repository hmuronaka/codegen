#coding: utf-8

module Codegen

TYPE_MAP = {
  'string' => "CString",
  'int' => "int",
  'list' => 'vector'
}

  module TypeResolver

    def resolve_type(type_name)
      TYPE_MAP.has_key?(type_name) ? TYPE_MAP[type_name] : type_name
    end

    def get_list_type
      TYPE_MAP['list']
    end

    def get_string_type
      TYPE_MAP['string']
    end

    def get_int_type
      TYPE_MAP['int']
    end

    def listize(type)
      "#{get_list_type}<#{resolve_type(type)}>"
    end
    
  end


end
