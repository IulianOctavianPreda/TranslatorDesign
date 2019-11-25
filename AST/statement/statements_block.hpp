#include <memory>
#include "../base/base_expression.hpp"
#include "../base/base_statement.hpp"
#include "../declarations/declaration_block.hpp"
#include "./statements_list.hpp"

class StatementsBlock : public BaseStatement {
 private:
  std::shared_ptr<StatementsList> _statements;
  std::shared_ptr<DeclarationBlock> _declarations;

 public:
  StatementsBlock(std::shared_ptr<StatementsList> statements,
                  std::shared_ptr<DeclarationBlock> declarations)
      : _statements(statements), _declarations(declarations) {}
};