#ifndef SCANNER_H
#define SCANNER_H

/**
 * Generated Flex class name is yyFlexLexer by default. If we want to use more
 * flex-generated classes we should name them differently. See scanner.l prefix
 * option.
 *
 * Unfortunately the implementation relies on this trick with redefining class
 * name with a preprocessor macro. See GNU Flex manual, "Generating C++
 * Scanners" section
 */
#if !defined(yyFlexLexerOnce)
#undef yyFlexLexer
#define yyFlexLexer CMM_FlexLexer
#include <FlexLexer.h>
#endif

// Scanner method signature is defined by this macro. Original yylex() returns
// int. Sinice Bison 3 uses symbol_type, we must change returned type. We also
// rename it to something sane, since you cannot overload return type.
#undef YY_DECL
#define YY_DECL CMM::Parser::symbol_type CMM::Scanner::get_next_token()

#include "parser.hpp"  // this is needed for symbol_type

namespace CMM {

// Forward declare interpreter to avoid include. Header is added in
// implementation file.
class Interpreter;

class Scanner : public yyFlexLexer {
 public:
  Scanner(Interpreter &driver) : m_driver(driver) {}
  virtual ~Scanner() {}
  virtual CMM::Parser::symbol_type get_next_token();

 private:
  Interpreter &m_driver;
};

}  // namespace CMM

#endif