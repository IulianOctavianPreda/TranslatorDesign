
%code{
   #include <iostream>
   #include <cstdlib>
   #include <fstream>
   
   /* include for all driver functions */
   #include "cmm_driver.hpp"

#undef yylex
#define yylex scanner.yylex
}

%define api.value.type variant
%define parse.assert

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



%locations

/*operator precedence*/
%left "&&" "||"
%right '!'
%left '>' '<' "<=" ">=" "!=" "=="
%left '+' '-'
%left '*' '/'