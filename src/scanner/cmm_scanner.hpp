#ifndef __CMMSCANNER_HPP__
#define __CMMSCANNER_HPP__ 1

#if !defined(yyFlexLexerOnce)
#include <FlexLexer.h>
#endif

#if __has_include("../parser/cmm_parser.tab.hh") && \
                  __has_include("../parser/location.hh")
#include "../parser/cmm_parser.tab.hh"
#include "../parser/location.hh"
#endif

#if !__has_include("../parser/cmm_parser.tab.hh") || \
                   !__has_include("../parser/location.hh")
#include "../test-files/scanner-module/mock_location.hh"
#include "../test-files/scanner-module/mock_tokens.hh"
#endif

#include <memory>

namespace CMM {

class CMM_Scanner : public yyFlexLexer {
 public:
  CMM_Scanner(std::istream *in) : yyFlexLexer(in){};
  CMM_Scanner(std::istream *in, std::ostream *out) : yyFlexLexer(in, out){};
  virtual ~CMM_Scanner(){};

  using FlexLexer::yylex;

  virtual int yylex(CMM::CMM_Parser::semantic_type *const lval,
                    CMM::CMM_Parser::location_type *location);

 private:
  std::unique_ptr<CMM::CMM_Parser::semantic_type> yylval;
};

} /* end namespace CMM */

#endif /* END __CMMSCANNER_HPP__ */
