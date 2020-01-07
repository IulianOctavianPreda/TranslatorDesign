#include "./symbolTable.h"

int insertedNodes = 0;

void initializeSymbolTable(int nodes) {
  currentNode = 0;
  SymbolTable = (SymbolNode**)malloc(sizeof(SymbolNode*) * nodes);
  int i;
  for (i = 0; i < nodes; i++) {
    SymbolTable[i] = NULL;
  }
}

void symbolTableInsert(char* context, char* type, char* name, int line) {
  insertedNodes++;
  if (!checkExistence(context, type, name, line)) {
    SymbolNode* node = (SymbolNode*)malloc(sizeof(SymbolNode));

    char* symbolName = (char*)malloc(sizeof(name));
    strcpy(symbolName, name);

    char* symbolType = (char*)malloc(sizeof(type));
    strcpy(symbolType, type);

    char* symbolContext = (char*)malloc(sizeof(context));
    strcpy(symbolContext, context);
    node->symbol_name = symbolName;
    node->symbol_type = symbolType;
    node->symbol_context = symbolContext;
    node->line = line;
    node->isAssigned = 0;

    SymbolTable[currentNode++] = node;
  }
}

// !strcmp(SymbolTable[i]->symbol_type, type) &&
// SymbolTable[i]->line == line)
// printf("symbol %s duplicated error on line %d and %d")
void symbolAssigned(char* context, char* name) {
  int i;

  for (i = 0; i < insertedNodes; i++) {
    if (!strcmp(SymbolTable[i]->symbol_context, context) &&
        !strcmp(SymbolTable[i]->symbol_name, name))
      SymbolTable[i]->isAssigned = 1;
  }
}
int checkExistence(char* context, char* type, char* name, int line) {
  int i;
  for (i = 0; i < insertedNodes; i++) {
    if (!strcmp(SymbolTable[i]->symbol_context, context) &&
        !strcmp(SymbolTable[i]->symbol_name, name)) {
      printf("symbol %s duplicated in context %s error on line %d and %d", name,
             type, line, SymbolTable[i]->line);
      return 1;
    }
  }
  return 0;
}

void printSymbolTable(int nodes) {
  int i;
  printf("\nInserted Nodes: %d\n", insertedNodes);
  for (i = 0; i < insertedNodes; i++) {
    printf("Context %s \nName: %s \nType: %s \nline:%d isAssigned:%d\n\n",
           SymbolTable[i]->symbol_context, SymbolTable[i]->symbol_name,
           SymbolTable[i]->symbol_type, SymbolTable[i]->line,
           SymbolTable[i]->isAssigned);
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

char context[255] = "";

void parseTree(TreeNode* Head) {
  int i;
  if (Head->u_type == syn_unit && !strcmp(Head->syn_name, "FnDecl")) {
    strcpy(context, Head->child[1]->child[0]->syn_name);
    symbolTableInsert("Global", Head->child[0]->child[0]->type_name,
                      Head->child[1]->child[0]->syn_name,
                      Head->child[1]->child[0]->lineno);
  }
  if (Head->u_type == syn_unit && !strcmp(Head->syn_name, "VarDecl")) {
    symbolTableInsert(context, Head->child[0]->child[0]->type_name,
                      Head->child[1]->child[0]->syn_name,
                      Head->child[1]->child[0]->lineno);
  }
  if (Head->u_type == syn_unit && !strcmp(Head->syn_name, "Stmt")) {
    for (i = 0; i < Head->childnum; i++) {
      if (Head->u_type == syn_unit && Head->child[i]->s_cont == S_Id) {
        symbolAssigned(context, Head->child[i]->child[0]->syn_name);
        break;
      }
    }
  }
  if (Head->childnum > 0) {
    for (i = 0; i < Head->childnum; i++) {
      if (Head->child[i]->s_cont != S_Type && Head->child[i]->s_cont != S_Id)
        parseTree(Head->child[i]);
    }
  }
}