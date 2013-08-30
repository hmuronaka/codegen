#pragma once

#include "IIni.h"
#include<vector>
using namespace std;

class IniHelper : public IIniType {
private:
  IniHelper();
  IniHelper(const IniHelper&);
  IniHelper& operator=(const IniHelper&);

public:
  static int_list_type loadIntList(const string_type& iniPath, const string_type& section, const string_type& key, int_type defaultValue);

  static string_list_type loadStringList(const string_type& iniPath, const string_type& section, const string_type& key, const string_type& defaultValue);

  static int_type loadInt(const string_type& iniPath, const string_type& section, const string_type& key, int_type defaultValue);

  static string_type loadString(const string_type& iniPath, const string_type& section, const string_type& key, const string_type& defaultValue);

  static string_type getString(const string_type& iniPath, const string_type& section, const string_type& key, const string_type& defaultValue);
};

