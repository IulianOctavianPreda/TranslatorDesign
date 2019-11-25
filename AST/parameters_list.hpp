#include <cassert>
#include <memory>
#include <vector>
#include "./base/base_expression.hpp"
#include "./declarations/function_declaration.hpp"

class ParametersList {
  std::vector<std::shared_ptr<BaseExpression>> _parameters;

 public:
  void Add(std::shared_ptr<BaseExpression> expression) {
    assert(expression);
    _parameters.push_back(expression);
  }

  int GetSize() const { return _parameters.size(); }

  friend class FunctionDeclaration;
};