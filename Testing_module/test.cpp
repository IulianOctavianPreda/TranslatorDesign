#include "./helpers/helpers.hpp"

namespace fs = std::filesystem;

bool getTestResult(std::string path, std::string baseFileName) {
  std::ifstream expectedFile, outputFile;

  std::string expectedFilename =
      path + "/tests/expected/" + baseFileName + ".expected";
  std::string outputFilename =
      path + "/tests/output/" + baseFileName + ".output";

  expectedFile.open(expectedFilename.c_str());
  outputFile.open(outputFilename.c_str());

  std::vector<int> expectedTokens;
  std::vector<int> outputTokens;

  std::string temp;

  while (getline(expectedFile, temp)) {
    std::vector<int> tempVector = splitString(temp);
    expectedTokens.insert(expectedTokens.end(), tempVector.begin(),
                          tempVector.end());
  }

  while (getline(outputFile, temp)) {
    std::vector<int> tempVector = splitString(temp);
    outputTokens.insert(outputTokens.end(), tempVector.begin(),
                        tempVector.end());
  }

  if (expectedTokens == outputTokens) {
    std::cout << baseFileName << " Passed" << std::endl;
  } else {
    std::cout << baseFileName << " Failed" << std::endl;
  }
  return expectedTokens == outputTokens;
}

int main(int argc, char **argv) {
  std::vector<std::string> args(argv + 1, argv + argc);
  if (argc == 1) {
    std::cout
        << "use -lex - to run all tests from default path '/lexer'" << std::endl
        << "use -lex <folder path to lexer> - to run all tests" << std::endl
        << "use -lex <folder path to lexer> <filename> - to run a specific test"
        << std::endl;
  } else {
    std::map<std::string, std::vector<std::string>> flags;
    std::string key;
    for (auto str : args) {
      if (str.find("-") == 0) {
        key = str;
        flags.insert(std::pair<std::string, std::vector<std::string>>(
            key, std::vector<std::string>()));
      } else {
        flags[key].push_back(str);
      }
    }
    if (flags.find("-lex") != flags.end()) {
      std::string path;
      if (flags["-lex"].size() == 0 || flags["-lex"].size() == 1) {
        if (flags["-lex"].size() == 0) {
          path = "./lexer";
        } else {
          path = flags["-lex"][0];
        }
        // run all tests from path
        int passedTests = 0;
        int totalTests = 0;
        for (const auto &entry :
             fs::directory_iterator(path + "/tests/input/")) {
          std::string filename(entry.path().filename());
          std::string basename = baseName(filename);
          std::string command = path + "/a.out -i " + path + "/tests/input/" +
                                filename + " -as " + path + "/tests/output/" +
                                basename + ".output";
          system(command.c_str());
          auto result = getTestResult(path, basename);
          passedTests = result ? passedTests + 1 : passedTests;
          totalTests++;
        }
        std::cout << passedTests << "/" << totalTests << " Tests Passed"
                  << std::endl;
      } else {
        // system("make");
        std::string filename(flags["-lex"][1]);
        std::string basename = baseName(filename);
        std::string command = path + "/a.out -i " + path + "/tests/input/" +
                              filename + " -as " + path + "/tests/output/" +
                              basename + ".output";
        system(command.c_str());
        getTestResult(path, basename);
      }
    }
  }
  return 0;
}
