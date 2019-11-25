#include <cassert>
#include <memory>
#include <vector>
#include "../base/base_statement.hpp"

class StatementsList {
  std::vector<std::shared_ptr<BaseStatement>> _statements;

 public:
  StatementsList* Add(std::shared_ptr<BaseStatement> statement) {
    assert(statement);
    _statements.push_back(statement);
    return this;
  }
};