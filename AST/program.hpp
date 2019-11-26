#include <cassert>
#include <memory>
#include "./declaration/declaration_block.hpp"
#include "./function_list.hpp"

class Program {
  std::shared_ptr<DeclarationBlock> _declarations;
  std::shared_ptr<FunctionList> _functions;

 public:
  Program(std::shared_ptr<DeclarationBlock> declarations,
          std::shared_ptr<FunctionList> functions)
      : _declarations(declarations), _functions(functions) {}
};