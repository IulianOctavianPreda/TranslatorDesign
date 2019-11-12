%{
#include <stdio.h>
#include "../ast/ast.h"
TreeNode* TreeRoot = NULL;
%}

%union{
    int intVal;
    char* stringVal;
}

%token               INT
%token               BOOL
%token               VOID
%token               TRUE
%token               FALSE
%token               IF
%token               ELSE
%token               WHILE
%token               RETURN
%token               CIN
%token               COUT
%token               RIGHT_OP
%token               LEFT_OP
%token               AND_OP
%token               OR_OP
%token               LE_OP
%token               GE_OP
%token               EQ_OP
%token               NE_OP
%token               SEMICOL
%token               LB
%token               RB
%token               COL 
%token               EQ 
%token               LRB 
%token               RRB 
%token               LSB 
%token               RSB 
%token               MINUS
%token               PLUS
%token               TIMES
%token               DIVIDE
%token               GL 
%token               GR 
%token               NOT 
%token				 IDENTIFIER 
%token	<intVal>	 NUMBER 
%token <stringVal>   STRINGLITERAL 
%token				 NEWLINE 
%token               END    0     "end of file"

/*operator precedence*/
%left "||"
%left "&&"
%right '!'
%left '>' '<' "<=" ">=" "!=" "=="
%left '+' '-'
%left '*' '/'
%left '(' ')'
%%
/*grammar*/
program
 : program varDecl { $$=GenerateTreeNode(S_Program,"Program",2,$1,$2); TreeRoot = $$;}
 | program fnDecl  { $$=GenerateTreeNode(S_Program,"Program",2,$1,$2); TreeRoot = $$;}
 | /* empty */     { $$=GenerateTreeNode(S_Program,"Program",-1); TreeRoot = $$;}
 ;
varDecl
 : type id SEMICOL             { $$=GenerateTreeNode(S_VarDecl,"VarDecl",3,$1,$2,$3); TreeRoot = $$;}
 | type id LSB INT RSB SEMICOL { $$=GenerateTreeNode(S_VarDecl,"VarDecl",6,$1,$2,$3,$4,$5,$6); TreeRoot = $$;}
 ;
type
 : INT  { $$=GenerateTreeNode(S_Type,"Type",1,$1); TreeRoot = $$;}
 | BOOL { $$=GenerateTreeNode(S_Type,"Type",1,$1); TreeRoot = $$;}
 | VOID { $$=GenerateTreeNode(S_Type,"Type",1,$1); TreeRoot = $$;}
 ;
fnDecl
 : type id parameters block { $$=GenerateTreeNode(S_FnDecl,"FnDecl",4,$1,$2,$3,$4); TreeRoot = $$;}
 ;
parameters
 : LRB LRB { $$=GenerateTreeNode(S_Parameters,"Parameters",2,$1,$2); TreeRoot = $$;}
 | LRB formalsList LRB { $$=GenerateTreeNode(S_Parameters,"Parameters",3,$1,$2,$3); TreeRoot = $$;}
 ;
formalsList
 : formalDecl { $$=GenerateTreeNode(S_FormalsList,"FormalsList",1,$1); TreeRoot = $$;}
 | formalsList ',' formalDecl { $$=GenerateTreeNode(S_FormalsList,"FormalsList",3,$1,$2,$3); TreeRoot = $$;}
 ;
formalDecl
 : type id  { $$=GenerateTreeNode(S_FormalDecl,"FormalDecl",2,$1,$2); TreeRoot = $$;}
 ;
block
 : LB declList stmtList RB { $$=GenerateTreeNode(S_Block,"Block",4,$1,$2,$3,$4); TreeRoot = $$;}
 ;
declList
 : declList varDecl { $$=GenerateTreeNode(S_DeclList,"DeclList",2,$1,$2); TreeRoot = $$;}
 | /* empty */      { $$=GenerateTreeNode(S_DeclList,"DeclList",-1); TreeRoot = $$;}
 ;
stmtList
 : stmtList stmt { $$=GenerateTreeNode(S_DeclList,"DeclList",2,$1,$2); TreeRoot = $$;}
 | /* empty */   { $$=GenerateTreeNode(S_StmtList,"StmtList",-1); TreeRoot = $$;}
 ;
stmt
 : CIN RIGHT_OP id SEMICOL  { $$=GenerateTreeNode(S_Stmt,"Stmt",4,$1,$2,$3,$4); TreeRoot = $$;}
 | CIN RIGHT_OP id LSB exp RSB SEMICOL { $$=GenerateTreeNode(S_Stmt,"Stmt",7,$1,$2,$3,$4,$5,$6,$7); TreeRoot = $$;}
 | COUT LEFT_OP exp SEMICOL { $$=GenerateTreeNode(S_Stmt,"Stmt",4,$1,$2,$3,$4); TreeRoot = $$;}
 | subscriptExpr EQ exp SEMICOL { $$=GenerateTreeNode(S_Stmt,"Stmt",4,$1,$2,$3,$4); TreeRoot = $$;}
 | id EQ exp SEMICOL { $$=GenerateTreeNode(S_Stmt,"Stmt",4,$1,$2,$3,$4); TreeRoot = $$;}
 | IF LRB exp LRB block { $$=GenerateTreeNode(S_Stmt,"Stmt",4,$1,$2,$3,$4); TreeRoot = $$;}
 | IF LRB exp LRB block ELSE block { $$=GenerateTreeNode(S_Stmt,"Stmt",7,$1,$2,$3,$4,$5,$6,$7); TreeRoot = $$;}
 | WHILE LRB exp LRB block { $$=GenerateTreeNode(S_Stmt,"Stmt",4,$1,$2,$3,$4); TreeRoot = $$;}
 | RETURN exp SEMICOL { $$=GenerateTreeNode(S_Stmt,"Stmt",3,$1,$2,$3); TreeRoot = $$;}
 | RETURN SEMICOL { $$=GenerateTreeNode(S_Stmt,"Stmt",2,$1,$2); TreeRoot = $$;}
 | fnCallStmt SEMICOL { $$=GenerateTreeNode(S_Stmt,"Stmt",2,$1,$2); TreeRoot = $$;}
 ;
exp
 : exp PLUS exp { $$=GenerateTreeNode(S_Exp,"Exp",3,$1,$2,$3); TreeRoot = $$;}
 | exp MINUS exp { $$=GenerateTreeNode(S_Exp,"Exp",3,$1,$2,$3); TreeRoot = $$;}
 | exp TIMES exp { $$=GenerateTreeNode(S_Exp,"Exp",3,$1,$2,$3); TreeRoot = $$;}
 | exp DIVIDE exp { $$=GenerateTreeNode(S_Exp,"Exp",3,$1,$2,$3); TreeRoot = $$;}
 | NOT exp  { $$=GenerateTreeNode(S_Exp,"Exp",2,$1,$2); TreeRoot = $$;}
 | exp AND_OP exp { $$=GenerateTreeNode(S_Exp,"Exp",3,$1,$2,$3); TreeRoot = $$;}
 | exp OR_OP exp { $$=GenerateTreeNode(S_Exp,"Exp",3,$1,$2,$3); TreeRoot = $$;}
 | exp EQ_OP exp { $$=GenerateTreeNode(S_Exp,"Exp",3,$1,$2,$3); TreeRoot = $$;}
 | exp NE_OP exp { $$=GenerateTreeNode(S_Exp,"Exp",3,$1,$2,$3); TreeRoot = $$;}
 | exp LE_OP exp { $$=GenerateTreeNode(S_Exp,"Exp",3,$1,$2,$3); TreeRoot = $$;}
 | exp GE_OP exp { $$=GenerateTreeNode(S_Exp,"Exp",3,$1,$2,$3); TreeRoot = $$;}
 | exp GL exp { $$=GenerateTreeNode(S_Exp,"Exp",3,$1,$2,$3); TreeRoot = $$;}
 | exp GR exp { $$=GenerateTreeNode(S_Exp,"Exp",3,$1,$2,$3); TreeRoot = $$;}
 | MINUS atom { $$=GenerateTreeNode(S_Exp,"Exp",2,$1,$2); TreeRoot = $$;}
 | atom { $$=GenerateTreeNode(S_Exp,"Exp",1,$1); TreeRoot = $$;}
 ;
atom
 : NUMBER  { $$=GenerateTreeNode(S_Atom,"Atom",1,$1); TreeRoot = $$;}
 | STRINGLITERAL  { $$=GenerateTreeNode(S_Atom,"Atom",1,$1); TreeRoot = $$;}
 | TRUE  { $$=GenerateTreeNode(S_Atom,"Atom",1,$1); TreeRoot = $$;}
 | FALSE  { $$=GenerateTreeNode(S_Atom,"Atom",1,$1); TreeRoot = $$;}
 | LRB exp LRB { $$=GenerateTreeNode(S_Atom,"Atom",3,$1,$2,$3); TreeRoot = $$;}
 | fnCallExpr  { $$=GenerateTreeNode(S_Atom,"Atom",1,$1); TreeRoot = $$;}
 | subscriptExpr  { $$=GenerateTreeNode(S_Atom,"Atom",1,$1); TreeRoot = $$;}
 | id  { $$=GenerateTreeNode(S_Atom,"Atom",1,$1); TreeRoot = $$;}
 ;
 
fnCallExpr
 : id LRB LRB  { $$=GenerateTreeNode(S_FnCallExpr,"FnCallExpr",3,$1,$2,$3); TreeRoot = $$;}
 | id LRB actualList LRB  { $$=GenerateTreeNode(S_FnCallExpr,"FnCallExpr",4,$1,$2,$3,$4); TreeRoot = $$;}
 ;
 
fnCallStmt
 : id LRB LRB { $$=GenerateTreeNode(S_FnCallStmt,"FnCallStmt",3,$1,$2,$3); TreeRoot = $$;}
 | id LRB actualList LRB { $$=GenerateTreeNode(S_FnCallStmt,"FnCallStmt",4,$1,$2,$3,$4); TreeRoot = $$;}
 ;
 
actualList
 : exp { $$=GenerateTreeNode(S_ActualList,"ActualList",1,$1); TreeRoot = $$;}
 | actualList ',' exp { $$=GenerateTreeNode(S_ActualList,"ActualList",3,$1,$2,$3); TreeRoot = $$;}
 ;
 
subscriptExpr
 : id LSB exp RSB { $$=GenerateTreeNode(S_SubscriptExpr,"SubscriptExpr",4,$1,$2,$3,$4); TreeRoot = $$;}
 ;
id
 : IDENTIFIER  { $$=GenerateTreeNode(S_Id,"Id",1,$1); TreeRoot = $$;}
 ;
%%
int main(int argc, char **argv)
{
 yyparse();
 return 0;
}

void yyerror(char *s)
{
 fprintf(stderr, "error: %s\n", s);
}