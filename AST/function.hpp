#include <cassert>
#include <memory>
#include "./declarations/function_declaration.hpp"
#include "./statements/statements_block.hpp"

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