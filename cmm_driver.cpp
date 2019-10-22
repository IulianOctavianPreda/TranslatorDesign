#include <cassert>
#include <cctype>
#include <fstream>

#include "cmm_driver.hpp"

CMM::CMM_Driver::~CMM_Driver() {
  delete (scanner);
  scanner = nullptr;
  delete (parser);
  parser = nullptr;
}

void CMM::CMM_Driver::parse(const char *const filename) {
  assert(filename != nullptr);
  std::ifstream in_file(filename);
  if (!in_file.good()) {
    exit(EXIT_FAILURE);
  }
  parse_helper(in_file);
  return;
}

void CMM::CMM_Driver::parse(std::istream &stream) {
  if (!stream.good() && stream.eof()) {
    return;
  }
  // else
  parse_helper(stream);
  return;
}

void CMM::CMM_Driver::parse_helper(std::istream &stream) {
  delete (scanner);
  try {
    scanner = new CMM::CMM_Scanner(&stream);
  } catch (std::bad_alloc &ba) {
    std::cerr << "Failed to allocate scanner: (" << ba.what()
              << "), exiting!!\n";
    exit(EXIT_FAILURE);
  }

  delete (parser);
  try {
    parser =
        new CMM::CMM_Parser((*scanner) /* scanner */, (*this) /* driver */);
  } catch (std::bad_alloc &ba) {
    std::cerr << "Failed to allocate parser: (" << ba.what()
              << "), exiting!!\n";
    exit(EXIT_FAILURE);
  }
  const int accept(0);
  if (parser->parse() != accept) {
    std::cerr << "Parse failed!!\n";
  }
  return;
}

// std::ostream &CMM::CMM_Driver::print(std::ostream &stream) { return (stream);
// }
