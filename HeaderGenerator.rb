# coding: utf-8
require './HeaderSectionGenerator.rb'
require './type_map.rb'
require './Indent.rb'

module Codegen 

  class HeaderGenerator
  
    def initialize
  
    end
  
    def generate(name, yaml)
      env = yaml['env']
      source = ""
      yaml['sections'].each do |section|
        generator = HeaderSectionGenerator.new(env)
        source << generator.generate(section)
        source << "\n"
      end
  
      string_type = TYPE_MAP['string']
      source.indent(<<STR
class #{name} : public IIni {
public:
  #{name}() {}
  ~#{name}() {}
private:
STR
                   ) do |s|
        yaml['sections'].each do |section|
          section_name = section['section']
          s.indent <<STR
#{section_name} _#{section_name};
STR
        end
        s << <<STR
public:
STR
        s.indent <<STR
virtual void load(const #{string_type}& iniPath);
virtual void save(const #{string_type}& iniPath);
STR
      end
      source.indent <<STR
};
STR
      source
    end
  end
  
end
