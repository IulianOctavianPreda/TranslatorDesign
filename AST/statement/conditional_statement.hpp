#include <memory>
#include "../base/base_expression.hpp"
#include "../base/base_statement.hpp"

class ConditionalStatement : public BaseStatement {
 private:
  std::shared_ptr<BaseExpression> _expression;
  std::shared_ptr<BaseStatement> _ifStatement, _elseStatement;

 public:
  ConditionalStatement(std::shared_ptr<BaseExpression> expression,
                       std::shared_ptr<BaseStatement> ifStatement,
                       std::shared_ptr<BaseStatement> elseStatement)
      : _expression(_expression),
        _ifStatement(_ifStatement),
        _elseStatement(_elseStatement) {}
};