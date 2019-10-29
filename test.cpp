#include <fstream>
#include <iostream>
#include <string>
#include <vector>

using namespace std;

vector<int> splitString(string str) {
  vector<int> tokens;
  string delimiter = " ";
  auto start = 0U;
  auto end = str.find(delimiter);
  while (end != std::string::npos) {
    tokens.push_back(stoi(str.substr(start, end - start)));
    start = end + delimiter.length();
    end = str.find(delimiter, start);
  }
  return tokens;
}

void compare(string filename) {
  ifstream inputFile, outputFile;
  string inputFilename = filename + ".input";
  inputFile.open(
      inputFilename.c_str());  // c_str() returns C-style string pointer
  outputFile.open("test.out");

  vector<int> inputTokens;
  vector<int> outputTokens;

  string temp;

  while (getline(inputFile, temp)) {
    vector<int> tempVector = splitString(temp);
    inputTokens.insert(inputTokens.end(), tempVector.begin(), tempVector.end());
  }

  while (getline(outputFile, temp)) {
    vector<int> tempVector = splitString(temp);
    outputTokens.insert(outputTokens.end(), tempVector.begin(),
                        tempVector.end());
  }

  if (inputTokens == outputTokens) {
    std::cout << "Both vectors are equal" << endl;
  } else {
    std::cout << "Both vectors are not equal" << endl;
  }
}

int main(int argc, char **argv) {
  // TODO change the hardcoded test.out to<filename>.output
  if (argc < 2) {
    cout << "you are required to input the filename. it will be taken and the "
            "program will seach for <filename>.input. then it will output "
            "<filename>.output and compare them";
  } else {
    // system("make");
    string filename(argv[1]);
    string command = "./a.out " + filename;
    system(command.c_str());
    compare(filename);
  }
  return 0;
}
