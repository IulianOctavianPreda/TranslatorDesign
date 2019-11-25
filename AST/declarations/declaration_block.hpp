#include <cassert>
#include <memory>
#include <string>
#include <vector>
#include "./variable_declaration.hpp"

class DeclarationBlock {
  int space;
  std::vector<std::shared_ptr<VariableDeclaration>> declarations;

 public:
  std::shared_ptr<VariableDeclaration> Find(std::string var) {
    for (auto declaration : declarations) {
      if (declaration->GetName() == var) {
        return declaration;
      }
    }
    return 0;
  }

  DeclarationBlock* Add(std::shared_ptr<VariableDeclaration> varDecl) {
    assert(varDecl);
    declarations.push_back(varDecl);
    return this;
  }

  int GetSize() const { return declarations.size(); }
};
