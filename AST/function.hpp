#include <cassert>
#include <memory>
#include "./declaration/function_declaration.hpp"
#include "./statement/statements_block.hpp"

class Function {
  std::shared_ptr<StatementsBlock> _statements;
  std::shared_ptr<FunctionDeclaration> _declaration;

 public:
  Function(std::shared_ptr<FunctionDeclaration> declaration,
           std::shared_ptr<StatementsBlock> statements)
      : _declaration(declaration), _statements(statements) {
    assert(declaration);
    assert(statements);
  }
};