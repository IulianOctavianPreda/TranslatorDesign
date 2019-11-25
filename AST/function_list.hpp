#include <cassert>
#include <memory>
#include <vector>
#include "./function.hpp"

class FunctionsList {
  vector<std::shared_ptr<Function>> _functions;

 public:
  void Add(std::shared_ptr<Function> funDecl) {
    assert(funDecl);
    _functions.push_back(funDecl);
    return this;
  }
};