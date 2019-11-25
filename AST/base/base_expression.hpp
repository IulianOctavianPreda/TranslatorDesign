class BaseExpression {
 public:
  virtual int GetType() const = 0;
  virtual ~BaseExpression() {}
};