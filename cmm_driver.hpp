#ifndef __CMMDRIVER_HPP__
#define __CMMDRIVER_HPP__ 1

#include <cstddef>
#include <istream>
#include <string>

#include "cmm_parser.tab.hh"
#include "cmm_scanner.hpp"

namespace CMM {

class CMM_Driver {
 public:
  CMM_Driver() = default;

  virtual ~CMM_Driver();

  /**
   * parse - parse from a file
   * @param filename - valid string with input file
   */
  void parse(const char *const filename);
  /**
   * parse - parse from a c++ input stream
   * @param is - std::istream&, valid input stream
   */
  void parse(std::istream &iss);

  // std::ostream &print(std::ostream &stream);

 private:
  void parse_helper(std::istream &stream);
  CMM::CMM_Parser *parser = nullptr;
  CMM::CMM_Scanner *scanner = nullptr;
};

} /* end namespace CMM */
#endif /* END __CMMDRIVER_HPP__ */
