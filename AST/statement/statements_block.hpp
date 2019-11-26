#include <memory>
#include "../base/base_expression.hpp"
#include "../base/base_statement.hpp"
#include "../declaration/declaration_block.hpp"
#include "../statement_list.hpp"

class StatementsBlock : public BaseStatement {
 private:
  std::shared_ptr<StatementList> _statements;
  std::shared_ptr<DeclarationBlock> _declarations;

 public:
  StatementsBlock(std::shared_ptr<StatementList> statements,
                  std::shared_ptr<DeclarationBlock> declarations)
      : _statements(statements), _declarations(declarations) {}
};