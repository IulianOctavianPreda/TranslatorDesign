#include <memory>
#include "../base/base_expression.hpp"
#include "../base/base_statement.hpp"

class ExpressionStatement : public BaseStatement {
 private:
  std::shared_ptr<BaseExpression> _expression;

 public:
  ExpressionStatement(std::shared_ptr<BaseExpression> expression)
      : _expression(expression) {}
};