#include "cmm_driver.hpp"
#include <cctype>
#include <memory>

void CMM::CMM_Driver::parse(std::istream &stream) {
  scanner = std::make_unique<CMM::CMM_Scanner>(&stream);
  parser = std::make_unique<CMM::CMM_Parser>(*scanner, *this);

  if (!parser->parse()) {
    std::cerr << "Parse failed!!\n";
  }
}
