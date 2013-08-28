#include"IniHelper.h"

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

IniHelper::string_list_type IniHelper::loadStringList(const IniHelper::string_type& iniPath, const IniHelper::string_type& section, const IniHelper::string_type& key, IniHelper::string_type& defaultValue) {
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
      result.push_back( GetString(section, key_list, defaultValue, iniPath));
    }
  }
  return result;
}

IniHelper::string getString(const string_type& iniPath, const string_type& section, const string_type& key, const string_type& defaultValue) {
  const int bufLen = 1024;
  TCHAR buf[bufLen];
  GetPrivateProfileString(section, key, defaultValue, buf, sizeof(buf) 
niPath);
  return CString(buf);
}
