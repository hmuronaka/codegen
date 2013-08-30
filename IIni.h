#pragma once

#include<vector>
using namespace std;

class IIniType {
protected:
  IIniType() {}
  virtual ~IIniType() {}

public:
  typedef int int_type;
  typedef CString string_type;
  typedef vector<int> int_list_type;
  typedef vector<CString> string_list_type;
};

class ISection : public IIniType {
public:
  ISection() {}
  virtual ~ISection {}

public:
  virtual void load(const string_type& iniPath, const string_type& section) {}
  virtual void save(const string_type& iniPath, const string_type& section) {}
};

class IIni: public IIniType {
public:
  IIni() {}
  virtual ~IIni() {}

public:
  virtual void load(const string_type& iniPath) {}
  virtual void save(const string_type& iniPath) {}
};

