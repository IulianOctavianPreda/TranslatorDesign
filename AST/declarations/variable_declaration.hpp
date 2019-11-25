#include <string>

class VariableDeclaration {
  std::string _name;
  int _type, _size;

 public:
  VariableDeclaration() : _type(0), _size(0) {}
  VariableDeclaration(std::string name, int type, int size)
      : _name(name), _type(type), _size(size) {}

  int GetType() const { return _type; }
  int GetSize() const { return _size; }
  const std::string& GetName() const { return _name; }
};
