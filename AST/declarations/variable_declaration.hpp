#include <string>

class VariableDeclaration {
  std::string name;
  int type, size;

 public:
  VariableDeclaration() : type(0), size(0) {}
  VariableDeclaration(std::string _name, int _type, int _size)
      : name(_name), type(_type), size(_size) {}

  int GetType() const { return type; }
  int GetSize() const { return size; }
  const std::string& GetName() const { return name; }
};
