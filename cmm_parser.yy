%skeleton "lalr1.cc"
%require  "3.0"
%debug 
%defines 
%define api.namespace {CMM}
%define parser_class_name {CMM_Parser}

%code requires{
   namespace CMM {
      class CMM_Driver;
      class CMM_Scanner;
   }

// The following definitions is missing when %locations isn't used
# ifndef YY_NULLPTR
#  if defined __cplusplus && 201103L <= __cplusplus
#   define YY_NULLPTR nullptr
#  else
#   define YY_NULLPTR 0
#  endif
# endif

}

%parse-param { CMM_Scanner  &scanner  }
%parse-param { CMM_Driver  &driver  }

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
%%
// grammar
%%


void 
CMM::CMM_Parser::error( const location_type &l, const std::string &err_message )
{
   std::cerr << "Error: " << err_message << " at " << l << "\n";
}
