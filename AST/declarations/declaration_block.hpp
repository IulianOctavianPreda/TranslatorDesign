#include <cassert>
#include <memory>
#include <string>
#include <vector>
#include "./variable_declaration.hpp"

class DeclarationBlock {
  std::vector<std::shared_ptr<VariableDeclaration>> _declarations;

 public:
  std::shared_ptr<VariableDeclaration> Find(std::string var) {
    for (auto declaration : _declarations) {
      if (declaration->GetName() == var) {
        return declaration;
      }
    }
    return 0;
  }

  void Add(std::shared_ptr<VariableDeclaration> varDecl) {
    assert(varDecl);
    _declarations.push_back(varDecl);
  }

  int GetSize() const { return _declarations.size(); }
};
