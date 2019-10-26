#ifndef __CMMDRIVER_HPP__
#define __CMMDRIVER_HPP__ 1

#include <cstddef>
#include <string>

#include "cmm_parser.tab.hh"
#include "cmm_scanner.hpp"

namespace CMM {

class CMM_Driver {
 public:
  CMM_Driver();
  // virtual ~CMM_Driver();

  // std::ostream &print(std::ostream &stream);

 private:
  void parse(std::istream &stream);
  CMM::CMM_Parser *parser = nullptr;
  CMM::CMM_Scanner *scanner = nullptr;
};

} /* end namespace CMM */
#endif /* END __CMMDRIVER_HPP__ */
