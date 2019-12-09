digit       [0-9]
number      {digit}+
letter      [a-zA-Z]
word        {letter}+
identifier  _|{letter}(_|{letter}|{digit}|_)*
newline     [(\r\n)|(\n)]
string      "((\\)|(\")|(\\\")|(\\')|(\\\')|(\\\\)|(\\n)|(\\t)|&|!|#|[a-zA-Z]|[0-9]|_)*"
/* blank - space and tabs */
whitespace  [:blank:]

%{

#if __has_include("../parser/parser.tab.h") 
  #include <stdlib.h>
  #include <string.h> 
  #include "../parser/parser.tab.h"
  #include "../ast/ast.h"

  int yycolumn = 1;
  #define YY_USER_ACTION \
  yylloc.first_line = yylloc.last_line = yylineno; \
  yylloc.first_column = yycolumn; \
  yylloc.last_column = yycolumn + yyleng - 1; \
  yycolumn += yyleng;
  #define YYDEBUG 1
#endif

#if !__has_include("../parser/parser.tab.h") 
  #include "mock_tokens.hh"
  #include "main.h"
#endif

void yyerror(char *);
/* define yyterminate as this instead of NULL */
#define yyterminate() return( END )
%}
%option nodefault
%option noyywrap
%option yylineno

%%
    /* Reserved keywords*/

int            { yylval.tnode = CreateTreeNode(L_TYPE, yytext, yylineno); return(INT); }
bool           { yylval.tnode = CreateTreeNode(L_TYPE, yytext, yylineno);return(BOOL); }
void           { yylval.tnode = CreateTreeNode(L_TYPE, yytext, yylineno);return(VOID); }
true           { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "TRUE", yylineno);return(TRUE); }
false          { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "FALSE", yylineno);return(FALSE); }
if             { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "IF", yylineno);return(IF); }
else           { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "ELSE", yylineno);return(ELSE); }
while          { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "WHILE", yylineno);return(WHILE); }
return         { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "RETURN", yylineno);return(RETURN); }
cin            { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "CIN", yylineno);return(CIN); }
cout           { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "COUT", yylineno);return(COUT); }


  /* comments */

^\/\/.*\n$     { /* comment */ }
^\#.*\n$       { /* comment */ }

  /* special characters */

\>\>            { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "RIGHT_OP", yylineno);return(RIGHT_OP); }
\<\<            { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "LEFT_OP", yylineno);return(LEFT_OP); }
\&\&            { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "AND_OP", yylineno);return(AND_OP); }
\|\|            { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "OR_OP", yylineno);return(OR_OP); }
\<\=            { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "LE_OP", yylineno);return(LE_OP); }
\>\=            { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "GE_OP", yylineno);return(GE_OP); }
\=\=            { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "EQ_OP", yylineno);return(EQ_OP); }
\!\=            { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "NE_OP", yylineno);return(NE_OP); }
\;              { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "SEMICOL", yylineno);return(SEMICOL); }
\{              { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "LB", yylineno);return(LB); }
\}              { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "RB", yylineno);return(RB); }
\,              { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "COL", yylineno);return(COL); }
\=              { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "EQ", yylineno);return(EQ); }
\(              { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "LRB", yylineno);return(LRB); }
\)              { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "RRB", yylineno);return(RRB); }
\[              { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "LSB", yylineno);return(LSB); }
\]              { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "RSB", yylineno);return(RSB); }
\-              { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "MINUS", yylineno);return(MINUS); }
\+              { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "PLUS", yylineno);return(PLUS); }
\*              { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "TIMES", yylineno);return(TIMES); }
\/              { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "DIVIDE", yylineno);return(DIVIDE); }
\<              { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "GL", yylineno);return(GL); }
\>              { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "GR", yylineno);return(GR); }
\!              { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "NOT", yylineno);return(NOT); }

{newline}       {
                  yycolumn = 1;
                  //return( NEWLINE );
                }
{number}        {
                  yylval.tnode = CreateTreeNode(L_INT, yytext, yylineno);
                  return( NUMBER ); 
                }

{whitespace}    { /* skip */ }

{string}        {
                  yylval.tnode = CreateTreeNode(L_STRING, yytext, yylineno);
                  return( STRINGLITERAL );
                }

{identifier}    {
                  yylval.tnode = CreateTreeNode(L_ID, yytext, yylineno);
                  return( IDENTIFIER );
                }

.               { /* skip */ }

<<EOF>>        {
                yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "END", yylineno);
                return ( END );
               }

%%
