#include <memory>
#include "../base/base_expression.hpp"
#include "../helpers/helpers.hpp"

class OperationExpression : public BaseExpression {
 private:
  std::shared_ptr<BaseExpression> left, right;
  int op;

 public:
  OperationExpression(int _op, std::shared_ptr<BaseExpression> _left,
                      std::shared_ptr<BaseExpression> _right)
      : left(_left), right(_right), op(_op) {}

  int GetType() const {
    return getOperation(op, left->GetType(), right->GetType());
  }
};