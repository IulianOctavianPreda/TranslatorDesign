#include <cassert>
#include <map>
#include <string>
#include <vector>

struct SValue {
  int type;
  union UValue {
    int integer;
  };

  UValue value;
};

int getOperation(int op, int typeLeft, int typeRight);
std::string getTypeName(int type);
std::string getOperationName(int op);