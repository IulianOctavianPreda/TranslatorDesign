#include <memory>
#include "../base/base_expression.hpp"
#include "../variable.hpp"

class AssignExpression : public BaseExpression {
  std::shared_ptr<Variable> _destination;
  std::shared_ptr<BaseExpression> _source;

 public:
  AssignExpression(std::shared_ptr<Variable> destination,
                   std::shared_ptr<BaseExpression> source)
      : _destination(destination), _source(source) {
    assert(destination);
    assert(source);
  }
  int GetType() const { return _destination->GetType(); }
};