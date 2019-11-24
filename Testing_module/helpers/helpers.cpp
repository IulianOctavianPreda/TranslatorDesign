#include "helpers.hpp"

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

std::vector<int> splitString(std::string str) {
  std::vector<int> tokens;
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