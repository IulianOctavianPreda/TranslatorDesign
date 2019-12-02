#ifndef _TREE_H_
#define _TREE_H_

#include <math.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef enum { lex_unit = 1, syn_unit } UnitType;

typedef enum {
  L_ID = 1,
  L_TYPE,
  L_INT,
  L_STRING,
  L_ANYTHINGELSE
} Lex_Unit_Cont;

typedef enum {
  S_empty = 1,
  S_Program,
  S_VarDecl,
  S_Type,
  S_FnDecl,
  S_Parameters,
  S_FormalsList,
  S_FormalDecl,
  S_Block,
  S_DeclList,
  S_StmtList,
  S_Stmt,
  S_Exp,
  S_Atom,
  S_FnCallExpr,
  S_FnCallStmt,
  S_ActualList,
  S_SubscriptExpr,
  S_Id
} Syn_Unit_Cont;

/* TreeNode Structure*/
typedef struct TreeNode {
  UnitType u_type;
  Syn_Unit_Cont s_cont;
  Lex_Unit_Cont l_cont;
  int childnum;
  struct TreeNode** child;
  union {
    char* syn_name;
    char* id_name;
    char* type_name;
    int int_value;
    char* string_value;
    char* anything_else_name;
  };
  int lineno;
} TreeNode;

TreeNode* CreateTreeNode(Lex_Unit_Cont l_cont, char* value, int lineno);

TreeNode* GenerateTreeNode(Syn_Unit_Cont s_cont, char* syn_name, int lineno,
                           int childnum, ...);

void PrintBlank(int deepth);

void DisplayTree(TreeNode* Head, int curdeepth);

int FreeTree(TreeNode* head);

void shownode(TreeNode* node);

#endif