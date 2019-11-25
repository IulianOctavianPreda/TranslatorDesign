#include <memory>
#include "../base/base_expression.hpp"
#include "../base/base_statement.hpp"

class ReturnStatement : public BaseStatement {
 private:
  std::shared_ptr<BaseExpression> expression;

 public:
  ReturnStatement(std::shared_ptr<BaseExpression> _expression)
      : expression(_expression) {}
};