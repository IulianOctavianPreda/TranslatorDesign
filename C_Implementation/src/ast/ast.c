#include "ast.h"

TreeNode* CreateTreeNode(Lex_Unit_Cont l_cont, char* value, int lineno) {
  TreeNode* node = (TreeNode*)malloc(sizeof(TreeNode));
  node->u_type = lex_unit;
  node->s_cont = 0;
  node->l_cont = l_cont;
  node->childnum = 0;
  node->child = NULL;
  node->lineno = lineno;
  switch (node->l_cont) {
    case L_ID: {
      node->id_name = (char*)malloc(strlen(value));
      strcpy(node->id_name, value);
      break;
    }
    case L_TYPE: {
      node->type_name = (char*)malloc(strlen(value));
      strcpy(node->type_name, value);
      break;
    }
    case L_INT: {
      node->int_value = atoi(value);
      break;
    }
    case L_STRING: {
      node->string_value = (char*)malloc(strlen(value));
      strcpy(node->string_value, value);
      break;
    }
    case L_ANYTHINGELSE: {
      node->anything_else_name = (char*)malloc(strlen(value));
      strcpy(node->anything_else_name, value);
      break;
    }
  }

  return node;
}

TreeNode* GenerateTreeNode(Syn_Unit_Cont s_cont, char* syn_name, int lineno,
                           int childnum, ...) {
  TreeNode* node = (TreeNode*)malloc(sizeof(TreeNode));

  node->u_type = syn_unit;
  node->s_cont = s_cont;
  node->l_cont = 0;
  node->childnum = childnum;
  node->lineno = lineno;
  va_list args;
  va_start(args, childnum);
  node->child = (TreeNode**)malloc(sizeof(TreeNode*) * abs(childnum));
  int count = 0;
  for (; count < abs(childnum); count++) {
    TreeNode* temp = va_arg(args, TreeNode*);
    node->child[count] = temp;
  }
  node->syn_name = syn_name;

  return node;
}

void DisplayTree(TreeNode* Head, int curdeepth) {
  PrintBlank(curdeepth);
  if (Head->u_type == syn_unit)
    printf("%s (%d)\n", Head->syn_name, Head->lineno);
  else {
    if (Head->l_cont == L_ID)
      printf("ID: %s\n", Head->id_name);
    else if (Head->l_cont == L_TYPE)
      printf("TYPE: %s\n", Head->type_name);
    else if (Head->l_cont == L_INT)
      printf("INT: %d\n", Head->int_value);
    else if (Head->l_cont == L_STRING)
      printf("STRING: %d\n", Head->string_value);
    else
      printf("%s\n", Head->anything_else_name);
  }

  if (Head->childnum < 0) return;
  if (Head->childnum > 0 && Head->child[0] != NULL) {
    int i;
    for (i = 0; i < Head->childnum; i++) {
      DisplayTree(Head->child[i], curdeepth + 1);
    }
  }
}

void PrintBlank(int deepth) {
  int temp = 0;
  for (; temp < deepth; temp++) printf("  ");
}

void shownode(TreeNode* node) {
  printf("%d\n", node->u_type);
  printf("%d\n", node->s_cont);
  printf("%d\n", node->l_cont);
  printf("%d\n", node->lineno);
}

void SaveTreeToFile(TreeNode* Head, int curdeepth, FILE* file) {
  AppendBlank(curdeepth, file);
  if (Head->u_type == syn_unit)
    fprintf(file, "%s (%d)\n", Head->syn_name, Head->lineno);
  else {
    if (Head->l_cont == L_ID)
      fprintf(file, "ID: %s\n", Head->id_name);
    else if (Head->l_cont == L_TYPE)
      fprintf(file, "TYPE: %s\n", Head->type_name);
    else if (Head->l_cont == L_INT)
      fprintf(file, "INT: %d\n", Head->int_value);
    else if (Head->l_cont == L_STRING)
      fprintf(file, "STRING: %d\n", Head->string_value);
    else
      fprintf(file, "%s\n", Head->anything_else_name);
  }

  if (Head->childnum < 0) return;
  if (Head->childnum > 0 && Head->child[0] != NULL) {
    int i;
    for (i = 0; i < Head->childnum; i++) {
      SaveTreeToFile(Head->child[i], curdeepth + 1, file);
    }
  }
}

void AppendBlank(int deepth, FILE* file) {
  int temp = 0;
  for (; temp < deepth; temp++) fprintf(file, "  ");
}

void FreeTree(TreeNode* Head) {
  if (Head->childnum < 0) {
    free(Head);
    return;
  };
  if (Head->childnum > 0 && Head->child[0] != NULL) {
    int i;
    for (i = 0; i < Head->childnum; i++) {
      FreeTree(Head->child[i]);
    }
  }
}

int CountIdentifiers(TreeNode* Head) {
  int counter = 0;
  if (Head->childnum > 0 && Head->child[0] != NULL) {
    int i;
    for (i = 0; i < Head->childnum; i++) {
      counter += CountIdentifiers(Head->child[i]);
    }
  }

  if (Head->l_cont == L_ID) return ++counter;
  return counter;
}

TreeNode** idNodes;
int indexIdNodes;

void GetIdentifiers(TreeNode* Head) {
  if (Head->childnum > 0 && Head->child[0] != NULL) {
    int i;
    for (i = 0; i < Head->childnum; i++) {
      GetIdentifiers(Head->child[i]);
    }
  }

  if (Head->l_cont == L_ID) {
    idNodes[indexIdNodes] = Head;
    indexIdNodes++;
  }
}

void CheckErrors(TreeNode** nodeList, int size) {
  int i, j;
  for (i = 0; i < size; i++) {
    for (j = 0; j < size; j++) {
      if (i != j && strcmp(nodeList[i]->id_name, nodeList[j]->id_name) == 0) {
        printf("Same identifier used - '%s' lines:%d, %d \n",
               idNodes[i]->id_name, idNodes[i]->lineno, idNodes[j]->lineno);
        break;
      }
    }
  }
}

void AnalyzeTree(TreeNode* Head) {
  int identifiers = CountIdentifiers(Head);

  idNodes = (TreeNode**)malloc(sizeof(TreeNode*) * identifiers);
  indexIdNodes = 0;

  GetIdentifiers(Head);

  CheckErrors(idNodes, identifiers);

  free(idNodes);
}