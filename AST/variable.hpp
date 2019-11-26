#include <cassert>
#include <memory>
#include "./base/base_expression.hpp"
#include "./declaration/variable_declaration.hpp"
// #include "./expressions/assign_expression.hpp"

class Variable : public BaseExpression {
  std::shared_ptr<BaseExpression> _index;
  std::shared_ptr<VariableDeclaration> _variable;

 public:
  Variable(std::shared_ptr<VariableDeclaration> variable,
           std::shared_ptr<BaseExpression> index)
      : _variable(variable), _index(index) {
    assert(variable);
  }

  int GetType() const {
    if (_index)
      return -_variable->GetType();
    else
      return _variable->GetType();
  }

  friend class AssignExpression;
};