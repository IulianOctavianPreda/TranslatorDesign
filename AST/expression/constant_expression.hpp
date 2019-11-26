#include "../base/base_expression.hpp"
#include "../helpers/helpers.hpp"

class ConstantExpression : public BaseExpression {
  SValue _constant;

 public:
  ConstantExpression(SValue constant) : _constant(constant) {}

  int GetType() const { return _constant.type; }
};