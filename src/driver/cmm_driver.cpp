#include "cmm_driver.hpp"
#include <cctype>
// To do, split parse function into scan and parse, adjust the scannning part ,
// remove those deletes???
////
///
//////
////
//
////
// CMM::CMM_Driver::~CMM_Driver() {
//   delete (scanner);
//   scanner = nullptr;
//   delete (parser);
//   parser = nullptr;
// }

void CMM::CMM_Driver::CMM_Driver() {
  scanner = std::make_unique;
  parser = std::make_unique<CMM::CMM_Parser>(
      {(*scanner) /* scanner */, (*this) /* driver */})
}

void CMM::CMM_Driver::parse(std::istream &stream) {
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
