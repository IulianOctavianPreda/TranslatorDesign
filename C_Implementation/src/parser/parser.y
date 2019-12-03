%{
#include <stdio.h>
#include "../ast/ast.h"
int yylex(void);
TreeNode* TreeRoot = NULL;
int HaveTree = 1;
extern FILE* yyin;
extern int yylineno;
%}

%locations 

%union{
    struct TreeNode *tnode;
}

%token <tnode>               INT
%token <tnode>               BOOL
%token <tnode>               VOID
%token <tnode>               TRUE
%token <tnode>               FALSE
%token <tnode>               IF
%token <tnode>               ELSE
%token <tnode>               WHILE
%token <tnode>               RETURN
%token <tnode>               CIN
%token <tnode>               COUT
%token <tnode>               RIGHT_OP
%token <tnode>               LEFT_OP
%token <tnode>               AND_OP
%token <tnode>               OR_OP
%token <tnode>               LE_OP
%token <tnode>               GE_OP
%token <tnode>               EQ_OP
%token <tnode>               NE_OP
%token <tnode>               SEMICOL
%token <tnode>               LB
%token <tnode>               RB
%token <tnode>               COL 
%token <tnode>               EQ 
%token <tnode>               LRB 
%token <tnode>               RRB 
%token <tnode>               LSB 
%token <tnode>               RSB 
%token <tnode>               MINUS
%token <tnode>               PLUS
%token <tnode>               TIMES
%token <tnode>               DIVIDE
%token <tnode>               GL 
%token <tnode>               GR 
%token <tnode>               NOT 
%token <tnode>				 IDENTIFIER 
%token <tnode>	             NUMBER 
%token <tnode>               STRINGLITERAL 
// %token <tnode>				 NEWLINE 
%token <tnode>               END    0     "end of file"


%type <tnode> Program VarDecl FnDecl Id Parameters Block FormalsList FormalDecl DeclList StmtList Stmt Exp Type SubscriptExpr FnCallExpr FnCallStmt ActualList Atom

/*operator precedence*/
%left OR_OP
%left AND_OP
%left GL GR LE_OP GE_OP EQ_OP NE_OP
%right NOT
%left PLUS MINUS
%left TIMES DIVIDE
%left LRB RRB LSB RSB

%%
/*grammar*/
Program
 : Program VarDecl { $$=GenerateTreeNode(S_Program,"Program",$1->lineno,2,$1,$2); TreeRoot = $$;}
 | Program FnDecl  { $$=GenerateTreeNode(S_Program,"Program",$1->lineno,2,$1,$2); TreeRoot = $$;}
 | /* empty */     { $$=GenerateTreeNode(S_Program,"Program",yylineno,-1); TreeRoot = $$;}
 ;
VarDecl
 : Type Id SEMICOL             { $$=GenerateTreeNode(S_VarDecl,"VarDecl",$1->lineno,3,$1,$2,$3); TreeRoot = $$;}
 | Type Id LSB INT RSB SEMICOL { $$=GenerateTreeNode(S_VarDecl,"VarDecl",$1->lineno,6,$1,$2,$3,$4,$5,$6); TreeRoot = $$;}
 ;
Type
 : INT  { $$=GenerateTreeNode(S_Type,"Type",$1->lineno,1,$1); TreeRoot = $$;}
 | BOOL { $$=GenerateTreeNode(S_Type,"Type",$1->lineno,1,$1); TreeRoot = $$;}
 | VOID { $$=GenerateTreeNode(S_Type,"Type",$1->lineno,1,$1); TreeRoot = $$;}
 ;
FnDecl
 : Type Id Parameters Block { $$=GenerateTreeNode(S_FnDecl,"FnDecl",$1->lineno,4,$1,$2,$3,$4); TreeRoot = $$;}
 ;
Parameters
 : LRB RRB { $$=GenerateTreeNode(S_Parameters,"Parameters",$1->lineno,2,$1,$2); TreeRoot = $$;}
 | LRB FormalsList RRB { $$=GenerateTreeNode(S_Parameters,"Parameters",$1->lineno,3,$1,$2,$3); TreeRoot = $$;}
 ;
FormalsList
 : FormalDecl { $$=GenerateTreeNode(S_FormalsList,"FormalsList",$1->lineno,1,$1); TreeRoot = $$;}
 | FormalsList COL FormalDecl { $$=GenerateTreeNode(S_FormalsList,"FormalsList",$1->lineno,3,$1,$2,$3); TreeRoot = $$;}
 ;
FormalDecl
 : Type Id  { $$=GenerateTreeNode(S_FormalDecl,"FormalDecl",$1->lineno,2,$1,$2); TreeRoot = $$;}
 ;
Block
 : LB DeclList StmtList RB { $$=GenerateTreeNode(S_Block,"Block",$1->lineno,4,$1,$2,$3,$4); TreeRoot = $$;}
 ;
DeclList
 : DeclList VarDecl { $$=GenerateTreeNode(S_DeclList,"DeclList",$1->lineno,2,$1,$2); TreeRoot = $$;}
 | /* empty */      { $$=GenerateTreeNode(S_DeclList,"DeclList",yylineno,-1); TreeRoot = $$;}
 ;
StmtList
 : StmtList Stmt { $$=GenerateTreeNode(S_DeclList,"DeclList",$1->lineno,2,$1,$2); TreeRoot = $$;}
 | /* empty */   { $$=GenerateTreeNode(S_StmtList,"StmtList",yylineno,-1); TreeRoot = $$;}
 ;
Stmt
 : CIN RIGHT_OP Id SEMICOL  { $$=GenerateTreeNode(S_Stmt,"Stmt",$1->lineno,4,$1,$2,$3,$4); TreeRoot = $$;}
 | CIN RIGHT_OP Id LSB Exp RSB SEMICOL { $$=GenerateTreeNode(S_Stmt,"Stmt",$1->lineno,7,$1,$2,$3,$4,$5,$6,$7); TreeRoot = $$;}
 | COUT LEFT_OP Exp SEMICOL { $$=GenerateTreeNode(S_Stmt,"Stmt",$1->lineno,4,$1,$2,$3,$4); TreeRoot = $$;}
 | SubscriptExpr EQ Exp SEMICOL { $$=GenerateTreeNode(S_Stmt,"Stmt",$1->lineno,4,$1,$2,$3,$4); TreeRoot = $$;}
 | Id EQ Exp SEMICOL { $$=GenerateTreeNode(S_Stmt,"Stmt",$1->lineno,4,$1,$2,$3,$4); TreeRoot = $$;}
 | IF LRB Exp LRB Block { $$=GenerateTreeNode(S_Stmt,"Stmt",$1->lineno,4,$1,$2,$3,$4); TreeRoot = $$;}
 | IF LRB Exp LRB Block ELSE Block { $$=GenerateTreeNode(S_Stmt,"Stmt",$1->lineno,7,$1,$2,$3,$4,$5,$6,$7); TreeRoot = $$;}
 | WHILE LRB Exp LRB Block { $$=GenerateTreeNode(S_Stmt,"Stmt",$1->lineno,4,$1,$2,$3,$4); TreeRoot = $$;}
 | RETURN Exp SEMICOL { $$=GenerateTreeNode(S_Stmt,"Stmt",$1->lineno,3,$1,$2,$3); TreeRoot = $$;}
 | RETURN SEMICOL { $$=GenerateTreeNode(S_Stmt,"Stmt",$1->lineno,2,$1,$2); TreeRoot = $$;}
 | FnCallStmt SEMICOL { $$=GenerateTreeNode(S_Stmt,"Stmt",$1->lineno,2,$1,$2); TreeRoot = $$;}
 ;
Exp
 : Exp PLUS Exp { $$=GenerateTreeNode(S_Exp,"Exp",$1->lineno,3,$1,$2,$3); TreeRoot = $$;}
 | Exp MINUS Exp { $$=GenerateTreeNode(S_Exp,"Exp",$1->lineno,3,$1,$2,$3); TreeRoot = $$;}
 | Exp TIMES Exp { $$=GenerateTreeNode(S_Exp,"Exp",$1->lineno,3,$1,$2,$3); TreeRoot = $$;}
 | Exp DIVIDE Exp { $$=GenerateTreeNode(S_Exp,"Exp",$1->lineno,3,$1,$2,$3); TreeRoot = $$;}
 | NOT Exp  { $$=GenerateTreeNode(S_Exp,"Exp",$1->lineno,2,$1,$2); TreeRoot = $$;}
 | Exp AND_OP Exp { $$=GenerateTreeNode(S_Exp,"Exp",$1->lineno,3,$1,$2,$3); TreeRoot = $$;}
 | Exp OR_OP Exp { $$=GenerateTreeNode(S_Exp,"Exp",$1->lineno,3,$1,$2,$3); TreeRoot = $$;}
 | Exp EQ_OP Exp { $$=GenerateTreeNode(S_Exp,"Exp",$1->lineno,3,$1,$2,$3); TreeRoot = $$;}
 | Exp NE_OP Exp { $$=GenerateTreeNode(S_Exp,"Exp",$1->lineno,3,$1,$2,$3); TreeRoot = $$;}
 | Exp LE_OP Exp { $$=GenerateTreeNode(S_Exp,"Exp",$1->lineno,3,$1,$2,$3); TreeRoot = $$;}
 | Exp GE_OP Exp { $$=GenerateTreeNode(S_Exp,"Exp",$1->lineno,3,$1,$2,$3); TreeRoot = $$;}
 | Exp GL Exp { $$=GenerateTreeNode(S_Exp,"Exp",$1->lineno,3,$1,$2,$3); TreeRoot = $$;}
 | Exp GR Exp { $$=GenerateTreeNode(S_Exp,"Exp",$1->lineno,3,$1,$2,$3); TreeRoot = $$;}
 | MINUS Atom { $$=GenerateTreeNode(S_Exp,"Exp",$1->lineno,2,$1,$2); TreeRoot = $$;}
 | Atom { $$=GenerateTreeNode(S_Exp,"Exp",$1->lineno,1,$1); TreeRoot = $$;}
 ;
Atom
 : NUMBER  { $$=GenerateTreeNode(S_Atom,"Atom",$1->lineno,1,$1); TreeRoot = $$;}
 | STRINGLITERAL  { $$=GenerateTreeNode(S_Atom,"Atom",$1->lineno,1,$1); TreeRoot = $$;}
 | TRUE  { $$=GenerateTreeNode(S_Atom,"Atom",$1->lineno,1,$1); TreeRoot = $$;}
 | FALSE  { $$=GenerateTreeNode(S_Atom,"Atom",$1->lineno,1,$1); TreeRoot = $$;}
 | LRB Exp LRB { $$=GenerateTreeNode(S_Atom,"Atom",$1->lineno,3,$1,$2,$3); TreeRoot = $$;}
 | FnCallExpr  { $$=GenerateTreeNode(S_Atom,"Atom",$1->lineno,1,$1); TreeRoot = $$;}
 | SubscriptExpr  { $$=GenerateTreeNode(S_Atom,"Atom",$1->lineno,1,$1); TreeRoot = $$;}
 | Id  { $$=GenerateTreeNode(S_Atom,"Atom",$1->lineno,1,$1); TreeRoot = $$;}
 ;
 
FnCallExpr
 : Id LRB RRB  { $$=GenerateTreeNode(S_FnCallExpr,"FnCallExpr",$1->lineno,3,$1,$2,$3); TreeRoot = $$;}
 | Id LRB ActualList RRB  { $$=GenerateTreeNode(S_FnCallExpr,"FnCallExpr",$1->lineno,4,$1,$2,$3,$4); TreeRoot = $$;}
 ;
 
FnCallStmt
 : Id LRB LRB { $$=GenerateTreeNode(S_FnCallStmt,"FnCallStmt",$1->lineno,3,$1,$2,$3); TreeRoot = $$;}
 | Id LRB ActualList LRB { $$=GenerateTreeNode(S_FnCallStmt,"FnCallStmt",$1->lineno,4,$1,$2,$3,$4); TreeRoot = $$;}
 ;
 
ActualList
 : Exp { $$=GenerateTreeNode(S_ActualList,"ActualList",$1->lineno,1,$1); TreeRoot = $$;}
 | ActualList COL Exp { $$=GenerateTreeNode(S_ActualList,"ActualList",$1->lineno,3,$1,$2,$3); TreeRoot = $$;}
 ;
 
SubscriptExpr
 : Id LSB Exp RSB { $$=GenerateTreeNode(S_SubscriptExpr,"SubscriptExpr",$1->lineno,4,$1,$2,$3,$4); TreeRoot = $$;}
 ;
Id
 : IDENTIFIER  { $$=GenerateTreeNode(S_Id,"Id",$1->lineno,1,$1); TreeRoot = $$;}
 ;
%%

int main(int argc, char** argv) {
    if( argc == 2){
        yyin = fopen(argv[1], "r");;  
    }
    yyparse();
    DisplayTree(TreeRoot,0);
    return 0;
}

void yyerror(char *s)
{
 fprintf(stderr, "error: %s\n", s);
}