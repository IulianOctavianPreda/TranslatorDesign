#include <algorithm>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <map>
#include <string>
#include <vector>

namespace fs = std::filesystem;
using namespace std;

bool contains(std::vector<std::string> vect, std::string searchWord) {
  return (std::find(vect.begin(), vect.end(), searchWord) != vect.end());
}

int indexOf(std::vector<std::string> vect, std::string searchWord) {
  return std::distance(vect.begin(),
                       std::find(vect.begin(), vect.end(), searchWord));
}

std::string baseName(std::string filename) {
  size_t lastindex = filename.find_last_of(".");
  return filename.substr(0, lastindex);
}

std::string extension(std::string filename) {
  size_t lastindex = filename.find_last_of(".");
  return filename.substr(lastindex, filename.length());
}

vector<std::string> splitString(string str) {
  vector<std::string> tokens;
  std::string delimiter = " ";
  auto start = 0U;
  auto end = str.find(delimiter);
  while (end != std::string::npos) {
    tokens.push_back(str.substr(start, end - start));
    start = end + delimiter.length();
    end = str.find(delimiter, start);
  }
  return tokens;
}

bool compare(string path, string filename) {
  std::ifstream expectedFile, outputFile;

  std::string expectedFilename =
      path + "/tests/expected/" + filename + ".expected";
  std::string outputFilename = path + "/tests/output/" + filename + ".output";

  expectedFile.open(expectedFilename.c_str());
  outputFile.open(outputFilename.c_str());

  std::vector<std::string> expectedTokens;
  std::vector<std::string> outputTokens;

  string temp;

  while (getline(expectedFile, temp)) {
    std::vector<std::string> tempVector = splitString(temp);
    expectedTokens.insert(expectedTokens.end(), tempVector.begin(),
                          tempVector.end());
  }

  while (getline(outputFile, temp)) {
    std::vector<std::string> tempVector = splitString(temp);
    outputTokens.insert(outputTokens.end(), tempVector.begin(),
                        tempVector.end());
  }

  if (expectedTokens == outputTokens) {
    std::cout << filename << " Passed" << endl;
  } else {
    std::cout << filename << " Failed" << endl;
  }
  return expectedTokens == outputTokens;
}

int main(int argc, char **argv) {
  std::vector<std::string> args(argv + 1, argv + argc);
  if (argc == 1) {
    cout
        << "use -lex - to run all tests from default path '/lexer'" << endl
        << "use -lex <folder path to lexer> - to run all tests" << endl
        << "use -lex <folder path to lexer> <filename> - to run a specific test"

        << "use -bison - to run all tests from default path '/parser'" << endl
        << endl;
  } else {
    std::map<std::string, std::vector<std::string>> flags;
    std::string key;
    for (auto str : args) {
      if (str.find("-") == 0) {
        key = str;
        flags.insert(pair<std::string, std::vector<std::string>>(
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
                                filename + " -toFile " + path +
                                "/tests/output/" + basename + ".output";
          system(command.c_str());
          auto result = compare(path, basename);
          passedTests = result ? passedTests + 1 : passedTests;
          totalTests++;
        }
        cout << passedTests << "/" << totalTests << " Tests Passed" << endl;
      } else {
        // system("make");
        std::string filename(flags["-lex"][1]);
        std::string basename = baseName(filename);
        std::string command = path + "/a.out -i " + path + "/tests/input/" +
                              filename + " -toFile " + path + "/tests/output/" +
                              basename + ".output";
        system(command.c_str());
        compare(path, basename);
      }
    }

    if (flags.find("-bison") != flags.end()) {
      std::string path;
      if (flags["-bison"].size() == 0 || flags["-bison"].size() == 1) {
        if (flags["-bison"].size() == 0) {
          path = "./parser";
        } else {
          path = flags["-bison"][0];
        }
        // run all tests from path
        int passedTests = 0;
        int totalTests = 0;
        for (const auto &entry :
             fs::directory_iterator(path + "/tests/input/")) {
          std::string filename(entry.path().filename());
          std::string basename = baseName(filename);
          std::string command = path + "/../../build/C-- -i " + path +
                                "/tests/input/" + filename + " -toFile " +
                                path + "/tests/output/" + basename + ".output";

          system(command.c_str());
          auto result = compare(path, basename);
          passedTests = result ? passedTests + 1 : passedTests;
          totalTests++;
        }
        cout << passedTests << "/" << totalTests << " Tests Passed" << endl;
      } else {
        // system("make");
        std::string filename(flags["-bison"][1]);
        std::string basename = baseName(filename);
        std::string command = path + "/../../build/C-- -i " + path +
                              "/tests/input/" + filename + " -toFile " + path +
                              "/tests/output/" + basename + ".output";
        system(command.c_str());
        compare(path, basename);
      }
    }
  }
  return 0;
}
