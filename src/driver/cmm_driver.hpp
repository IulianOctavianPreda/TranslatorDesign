#ifndef __CMMDRIVER_HPP__
#define __CMMDRIVER_HPP__ 1

#include <cstddef>
#include <memory>
#include <string>

#include "../parser/cmm_parser.tab.hh"
#include "../scanner/cmm_scanner.hpp"

namespace CMM {

class CMM_Driver {
 public:
  CMM_Driver() = default;
  void parse(std::istream &stream);

 private:
  std::unique_ptr<CMM::CMM_Parser> parser;
  std::unique_ptr<CMM::CMM_Scanner> scanner;
};

} /* end namespace CMM */
#endif /* END __CMMDRIVER_HPP__ */
