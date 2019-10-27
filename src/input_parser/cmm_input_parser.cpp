#include "cmm_input_parser.hpp"

void CMM::CMM_Input_Parser::parse_input(
    const std::string filename,
    std::function<void(std::istream &stream)> scan) {
  assert(filename != nullptr);
  std::ifstream in_file(filename);
  if (!in_file.good()) {
    exit(EXIT_FAILURE);
  }
  scan(in_file);
}

void CMM::CMM_Input_Parser::parse_input(
    std::istream &stream, std::function<void(std::istream &stream)> scan) {
  if (!stream.good() && stream.eof()) {
    return;
  }
  scan(stream);
}