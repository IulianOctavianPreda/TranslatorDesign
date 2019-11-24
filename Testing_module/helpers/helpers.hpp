#include <algorithm>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <map>
#include <string>
#include <vector>

bool contains(std::vector<std::string> vect, std::string searchWord);
int indexOf(std::vector<std::string> vect, std::string searchWord);
std::string baseName(std::string filename);
std::string extension(std::string filename);
std::vector<int> splitString(std::string str);
