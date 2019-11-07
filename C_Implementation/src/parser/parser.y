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
%token				 IDENTIFIER 
%token				 NUMBER 
%token				 NEWLINE 
%token				 STRINGLITERAL 
%token               END    0     "end of file"

/*operator precedence*/
%left "&&" "||"
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
 : type id ';'
 | type id '[' INT ']' ';'
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
 : CIN READ id ';'
 | CIN READ id '[' exp ']' ';'
 | COUT WRITE exp ';'
 | subscriptExpr '=' exp ';'
 | id '=' exp ';'
 | IF '(' exp ')' block
 | IF '(' exp ')' block ELSE block
 | WHILE '(' exp ')' block
 | RETURN exp ';'
 | RETURN ';'
 | fnCallStmt ';'
 ;
exp
 : exp '+' exp
 | exp '-' exp
 | exp '*' exp
 | exp '/' exp
 | '!' exp
 | exp ANDAND exp
 | exp OROR exp
 | exp EQEQ exp
 | exp NOTEQ exp
 | exp '<' exp
 | exp '>' exp
 | exp LESSEQ exp
 | exp GREATEREQ exp
 | '-' atom
 | atom
 ;
atom
 : INT
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