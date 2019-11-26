#include <memory>
#include "../base/base_expression.hpp"
#include "../declaration/function_declaration.hpp"
#include "../parameter_list.hpp"

class CallableExpression : public BaseExpression {
  std::shared_ptr<ParameterList> _parameters;
  std::shared_ptr<FunctionDeclaration> _function;

 public:
  CallableExpression(std::shared_ptr<ParameterList> parameters,
                     std::shared_ptr<FunctionDeclaration> function)
      : _parameters(parameters), _function(function) {}

  int GetType() const { return _function->GetType(); }
};
