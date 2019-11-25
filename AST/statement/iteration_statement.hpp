#include <memory>
#include "../base/base_expression.hpp"
#include "../base/base_statement.hpp"

class IterationStatement : public BaseStatement {
 private:
  std::shared_ptr<BaseExpression> _expression;
  std::shared_ptr<BaseStatement> _statement;

 public:
  IterationStatement(std::shared_ptr<BaseExpression> expression,
                     std::shared_ptr<BaseStatement> statement)
      : _expression(expression), _statement(statement) {}
};