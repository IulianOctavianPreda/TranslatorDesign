#include <cassert>
#include <fstream>
#include <functional>
#include <istream>

namespace CMM {
class CMM_Input_Parser {
 public:
  /**
   * parse the input from a file
   * @param filename - valid string with input file
   */
  static void parse_input(const char *const filename,
                          std::function<void(std::istream &stream)> scan);
  /**
   * parse the input from c++ input stream
   * @param is - std::istream&, valid input stream
   */
  static void parse_input(std::istream &stream,
                          std::function<void(std::istream &stream)> scan);
};
}  // namespace CMM

void CMM::CMM_Input_Parser::parse_input(
    const char *const filename,
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