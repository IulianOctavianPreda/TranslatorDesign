#include "./symbolTable.h"

void initializeSymbolTable(int nodes) {
  currentNode - 0;
  SymbolTable = (SymbolNode**)malloc(sizeof(SymbolNode*) * nodes);
  int i;
  for (i = 0; i < nodes; i++) {
    SymbolTable[i] = (SymbolNode*)malloc(sizeof(SymbolNode) * nodes);
  }
}

void symbolTableInsert(char* name, char* type) {
  strcpy(SymbolTable[currentNode]->symbol_name, name);
  strcpy(SymbolTable[currentNode]->symbol_type, type);
}

void printSymbolTable(int nodes) {
  int i;
  for (i = 0; i < nodes; i++) {
    printf("Name: %s \n Type: %s \n", SymbolTable[i]->symbol_name,
           SymbolTable[i]->symbol_type);
  }
}
