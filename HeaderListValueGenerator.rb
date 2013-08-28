require './HeaderValueGenerator.rb'
require './CppHelper.rb'
require './type_map.rb'

module Codegen

  class HeaderListValueGenerator 
  
    include TypeResolver
    include CppHelper
  
    def initialize(env, type)
      @env = env
      @type = type
    end
  
    def generate(value_def)
      comment = commentize value_def['comment']
      type = resolve_type @type 
      name = value_def['attr'].chomp
      source =<<STR
#{comment}
#{listize type} #{name};
STR
      source
    end

    def generate_method(value_def)
      value_type = resolve_type @type 
      type = listize value_type
      attr = value_def['attr'].chomp
      source =<<STR
void set_#{attr}(const #{value_type}& value, int index) { 
  _#{attr}[index] = value;
}

const #{value_type}&  get_#{attr}(int index) const {
  return _#{attr}[index];
}

int get_#{attr}_len const {
  return _#{attr}.size();
}

const #{type}& get_#{attr}_list const {
  return _#{attr};
}
STR
    end
  end
  
end
