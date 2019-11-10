%{
#include <stdio.h>
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
%%
/*grammar*/
program
 : program varDecl
 | program fnDecl
 | /* empty */
 ;
varDecl
 : type id SEMICOL
 | type id '[' INT ']' SEMICOL
 ;
type
 : INT
 | BOOL
 | VOID
 ;
fnDecl
 : type id parameters block
 ;
parameters
 : '(' ')'
 | '(' formalsList ')'
 ;
formalsList
 : formalDecl
 | formalsList ',' formalDecl
 ;
formalDecl
 : type id
 ;
block
 : '{' declList stmtList '}'
 ;
declList
 : declList varDecl
 | /* empty */
 ;
stmtList
 : stmtList stmt
 | /* empty */
 ;
stmt
 : CIN RIGHT_OP id SEMICOL
 | CIN RIGHT_OP id '[' exp ']' SEMICOL
 | COUT LEFT_OP exp SEMICOL
 | subscriptExpr EQ exp SEMICOL
 | id EQ exp SEMICOL
 | IF '(' exp ')' block
 | IF '(' exp ')' block ELSE block
 | WHILE '(' exp ')' block
 | RETURN exp SEMICOL
 | RETURN SEMICOL
 | fnCallStmt SEMICOL
 ;
exp
 : exp PLUS exp
 | exp MINUS exp
 | exp TIMES exp
 | exp DIVIDE exp
 | NOT exp
 | exp AND_OP exp
 | exp OR_OP exp
 | exp EQ_OP exp
 | exp NE_OP exp
 | exp LE_OP exp
 | exp GE_OP exp
 | exp GL exp
 | exp GR exp
 | MINUS atom
 | atom
 ;
atom
 : NUMBER
 | STRINGLITERAL
 | TRUE
 | FALSE
 | '(' exp ')'
 | fnCallExpr
 | subscriptExpr
 | id
 ;
 
fnCallExpr
 : id '(' ')'
 | id '(' actualList ')'
 ;
 
fnCallStmt
 : id '(' ')'
 | id '(' actualList ')'
 ;
 
actualList
 : exp
 | actualList ',' exp
 ;
 
subscriptExpr
 : id '[' exp ']'
 ;
id
 : IDENTIFIER
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