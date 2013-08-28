require './TypeMap.rb'

module Codegen

  def self.generate_IniHelper_Header
   return <<STR
#pragma once

class IniHelper {
public:
  typedef #{TYPE_MAP['int']} int_type;
  typedef #{TYPE_MAP['list']}<int_type> int_list_type;
  typedef #{TYPE_MAP['string']} string_type;
  typedef #{TYPE_MAP['list']}<string_type> string_list_type;

private:
  IniHelper();
  IniHelper(const IniHelper&);
  IniHelper& operator=(const IniHelper&);

public:
  static int_list_type loadIntList(const string_type& iniPath, const string_type& section, const string_type& key, int_type defaultValue);

  static string_list_type loadStringList(const string_type& iniPath, const string_type& section, const string_type& key, string_typedefaultValue);
};

  static int_type loadInt(const string_type& iniPath, const string_type& section, const string_type& key, int_type defaultValue);

  static string_type loadString(const string_type& iniPath, const string_type& section, const string_type& key, const string_type& defaultValue);
STR
  end

  def generate_IniHelper_Cpp
   return <<STR

IniHelper::int_list_type IniHelper::loadIntList(const IniHelper::string_type& iniPath, const IniHelper::string_type& section, const IniHelper::string_type& key, IniHelper::int_type defaultValue) {
  CString key_len;
  key.Format(_T("%s_len"), key);
  int_type len = GetPrivateProfileInt(section, key_len, 0, iniPath);

  int_list_type result;
  if( len == 0 ) {
    result.push_back( GetPrivateProfileInt(section, key, defaultValue, iniPath)); 
  }
  else {
    for(int i = 0; i < len; i++) {
      CString key_list;
      key_list.Format(_T("%s_%i"), key, i);
      result.push_back( GetPrivateProfileInt(section, key_list, defaultValue, iniPath));
    }
  }
  return result;
}

IniHelper::string_type IniHelper::loadStringList(const IniHelper::string_type& iniPath, const IniHelper::string_type& section, const IniHelper::string_type& key, IniHelper::string_type& defaultValue) {
  CString key_len;
  key.Format(_T("%s_len"), key);
  int_type len = GetPrivateProfileInt(section, key_len, 0, iniPath);

  string_list_type result;
  if( len == 0 ) {
    result.push_back( GetPrivateProfileString(section, key, defaultValue, iniPath)); 
  }
  else {
    for(int i = 0; i < len; i++) {
      CString key_list;
      key_list.Format(_T("%s_%i"), key, i);
      result.push_back( GetPrivateProfileInt(section, key_list, defaultValue, iniPath));
    }
  }
  return result;
}

STR
  end
end
