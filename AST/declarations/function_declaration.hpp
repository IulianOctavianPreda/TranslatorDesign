#include <cassert>
#include <memory>
#include <std::>
#include <string>
#include "./variable_declaration.hpp"

class FunctionDeclaration {
  std::vector<std::shared_ptr<DeclarationBlock>> _scopes;
  std::shared_ptr<DeclarationBlock> _parameters;
  std::string _name;
  int _type;

 public:
  FunctionDeclaration(std::string name, int type,
                      std::shared_ptr<DeclarationBlock> parameters)
      : _name(name), _type(type), _parameters(parameters) {
    assert(parameters);
  }

  const string& GetName() const { return _name; }
  int GetType() const { return _type; }
  std::shared_ptr<DeclarationBlock> GetParameters() const {
    return _parameters;
  }

  int Match(std::shared_ptr<ParamList> params) {
    if (params->GetSize() != _parameters->GetSize())
      return 0;
    else {
      for (int i = 0; i < _parameters->_declarations.size(); i++)
        if (_parameters->_declarations[i]->GetType() !=
            params->_parameters[i]->GetType())
          return i + 1;
      return -1;
    }
  }

  void AddScope(shared_ptr<DeclarationBlock> scope) {
    _scopes.push_back(scope);
  }
};