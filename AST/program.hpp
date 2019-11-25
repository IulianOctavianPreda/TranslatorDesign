#include <cassert>
#include <memory>
#include "./declarations/declaration_block.hpp"
#include "./functio_list.hpp"

class Program {
  std::shared_ptr<DeclarationBlock> _declarations;
  std::shared_ptr<FunctionsList> _functions;

 public:
  Program(DeclarationBlock* declarations, FunctionsList* functions)
      : _declarations(declarations), _functions(functions) {}
};