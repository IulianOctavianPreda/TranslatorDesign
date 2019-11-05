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

vector<int> splitString(string str) {
  vector<int> tokens;
  std::string delimiter = " ";
  auto start = 0U;
  auto end = str.find(delimiter);
  while (end != std::string::npos) {
    tokens.push_back(stoi(str.substr(start, end - start)));
    start = end + delimiter.length();
    end = str.find(delimiter, start);
  }
  return tokens;
}

void compare(string path, string filename) {
  std::ifstream expectedFile, outputFile;

  std::string expectedFilename =
      path + "/tests/expected/" + filename + ".expected";
  std::string outputFilename = path + "/tests/output/" + filename + ".output";

  expectedFile.open(expectedFilename.c_str());
  outputFile.open(outputFilename.c_str());

  std::vector<int> expectedTokens;
  std::vector<int> outputTokens;

  string temp;

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
    std::cout << "Passed" << endl;
  } else {
    std::cout << "Failed" << endl;
  }
}

int main(int argc, char **argv) {
  std::vector<std::string> args(argv + 1, argv + argc);
  if (argc == 1) {
    cout
        << "use -lex <folder path to lexer> - to run all tests" << endl
        << "use -lex <folder path to lexer> <filename> - to run a specific test"
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
      std::string path(flags["-lex"][0]);
      if (flags["-lex"].size() == 1) {
        // run all tests from path
        for (const auto &entry :
             fs::directory_iterator(path + "/tests/input/")) {
          std::string filename(entry.path().filename());
          std::string basename = baseName(filename);
          std::string command = path + "/a.out -i " + path + "/tests/input/" +
                                filename + " -as " + path + "/tests/output/" +
                                basename + ".output";
          system(command.c_str());
          compare(path, basename);
        }
      } else {
        // system("make");
        std::string filename(flags["-lex"][1]);
        std::string basename = baseName(filename);
        std::string command = path + "/a.out -i " + path + "/tests/input/" +
                              filename + " -as " + path + "/tests/output/" +
                              basename + ".output";
        system(command.c_str());
        compare(path, basename);
      }
    }
  }
  return 0;
}
