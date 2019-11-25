#include <memory>
#include "../base/base_expression.hpp"
#include "../helpers/helpers.hpp"

class OperationExpression : public BaseExpression {
 private:
  std::shared_ptr<BaseExpression> _left, _right;
  int _op;

 public:
  OperationExpression(int op, std::shared_ptr<BaseExpression> left,
                      std::shared_ptr<BaseExpression> right)
      : _left(left), _right(right), _op(op) {}

  int GetType() const {
    return getOperation(_op, _left->GetType(), _right->GetType());
  }
};