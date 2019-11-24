#include "../base/base_expression.hpp"
#include "../base/base_statement.hpp"

class ReturnStatement : public BaseStatement {
 private:
  BaseExpression* expression;

 public:
  ReturnStatement(BaseExpression* _expression) : expression(_expression) {}
  //~ReturnStatement() { delete expression; }
};