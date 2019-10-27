#ifndef __CMMDRIVER_HPP__
#define __CMMDRIVER_HPP__ 1

#include <cstddef>
#include <string>
#include <memory>

#include "../parser/cmm_parser.tab.hh"
#include "../scanner/cmm_scanner.hpp"

namespace CMM {

class CMM_Driver {
 public:
  CMM_Driver();

 private:
  void parse(std::istream &stream);
  std::unique_ptr<CMM::CMM_Parser> parser;
  std::unique_ptr<CMM_Scanner> scanner;
};

} /* end namespace CMM */
#endif /* END __CMMDRIVER_HPP__ */
