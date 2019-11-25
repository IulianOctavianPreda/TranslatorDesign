#include <memory>
#include "../base/base_expression.hpp"
#include "../base/base_statement.hpp"

class ConditionalStatement : public BaseStatement {
 private:
  std::shared_ptr<BaseExpression> expression;
  std::shared_ptr<BaseStatement> ifStatement, elseStatement;

 public:
  ConditionalStatement(std::shared_ptr<BaseExpression> _expression,
                       std::shared_ptr<BaseStatement> _ifStatement,
                       std::shared_ptr<BaseStatement> _elseStatement)
      : expression(_expression),
        ifStatement(_ifStatement),
        elseStatement(_elseStatement) {}
};