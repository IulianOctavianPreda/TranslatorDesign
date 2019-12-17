#include "./symbolTable.h"

void initializeSymbolTable(int nodes) {
  currentNode = 0;
  SymbolTable = (SymbolNode**)malloc(sizeof(SymbolNode*) * nodes);
  int i;
  for (i = 0; i < nodes; i++) {
    SymbolTable[i] = NULL;
  }
}

void symbolTableInsert(char* name, char* type) {
  SymbolNode* node = (SymbolNode*)malloc(sizeof(SymbolNode));

  char* symbolName = (char*)malloc(sizeof(name));
  strcpy(symbolName, name);

  char* symbolType = (char*)malloc(sizeof(type));
  strcpy(symbolType, name);
  node->symbol_name = symbolName;
  node->symbol_type = symbolType;
  SymbolTable[currentNode++] = node;
}

void printSymbolTable(int nodes) {
  int i;
  for (i = 0; i < nodes; i++) {
    printf("Name: %s \n Type: %s \n", SymbolTable[i]->symbol_name,
           SymbolTable[i]->symbol_type);
  }
}

int countSyntaxNodes(TreeNode* Head) {
  int counter = 0;
  if (Head->childnum > 0) {
    int i;
    for (i = 0; i < Head->childnum; i++) {
      counter += countSyntaxNodes(Head->child[i]);
    }
  }
  // printf("%d", Head->u_type);
  if (Head->u_type == syn_unit) return ++counter;
  return counter;
}

void parseTree(TreeNode* Head) {
  if (Head->childnum > 0) {
    int i;
    for (i = 0; i < Head->childnum; i++) {
      parseTree(Head->child[i]);
    }
  }

  if (Head->u_type == syn_unit)
    symbolTableInsert(Head->syn_name, Head->type_name);
}