#include <cassert>
#include <fstream>
#include <functional>
#include <istream>
#include <string>

namespace CMM {
class CMM_Input_Parser {
 public:
  /**
   * parse the input from a file
   * @param filename - valid string with input file
   */
  static void parse_input(const std::string filename,
                          std::function<void(std::istream &stream)> scan);
  /**
   * parse the input from c++ input stream
   * @param is - std::istream&, valid input stream
   */
  static void parse_input(std::istream &stream,
                          std::function<void(std::istream &stream)> scan);
};
}  // namespace CMM
