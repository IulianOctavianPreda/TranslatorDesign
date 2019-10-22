#ifndef __CMMSCANNER_HPP__
#define __CMMSCANNER_HPP__ 1

#if !defined(yyFlexLexerOnce)
#include <FlexLexer.h>
#endif

namespace CMM {

class CMM_Scanner : public yyFlexLexer {
 public:
  CMM_Scanner(std::istream *in) : yyFlexLexer(in){};
  virtual ~CMM_Scanner(){};

  using FlexLexer::yylex;
};

}  // namespace CMM

#endif
