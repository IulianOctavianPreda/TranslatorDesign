#ifndef _SYMBOLTABLE_H_
#define _SYMBOLTABLE_H_

// #include "TypeNode.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../ast/ast.h"

typedef struct SymbolNode {
  char* symbol_name;
  char* symbol_type;
} SymbolNode;

SymbolNode** SymbolTable;
int currentNode;

void symbolTableInsert(char* name, char* type);
void printSymbolTable(int nodes);
void initializeSymbolTable(int nodes);
void parseTree(TreeNode* root);
int countSyntaxNodes(TreeNode* Head);
#endif
