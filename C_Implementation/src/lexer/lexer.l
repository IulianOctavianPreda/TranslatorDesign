digit       [0-9]
number      {digit}+
letter      [a-zA-Z]
word        {letter}+
identifier  (_|{letter})({letter}|{digit}|_)*
newline     [(\r\n)|(\n)]
string      "((\\)|(\")|(\\\")|(\\')|(\\\')|(\\\\)|(\\n)|(\\t)|&|!|#|[a-zA-Z]|[0-9]|_)*"
/* blank - space and tabs */
whitespace  [:blank:]

%{

#if __has_include("../parser/parser.tab.h") 
  #include <stdlib.h>
  #include "../parser/parser.tab.h"
#endif

#if !__has_include("../parser/parser.tab.h") 
  #include "mock_tokens.hh"
  #include "main.h"
#endif

/* define yyterminate as this instead of NULL */
#define yyterminate() return( END )
/* output token to file*/
#define ECHO fwrite( yytext, yyleng, 1, yyout )
%}
%option nodefault
%option noyywrap

%%

%{          
   int yylval;
%}
        
    /* Reserved keywords*/

int            { return(INT); }
bool           { return(BOOL); }
void           { return(VOID); }
true           { return(TRUE); }
false          { return(FALSE); }
if             { return(IF); }
else           { return(ELSE); }
while          { return(WHILE); }
return         { return(RETURN); }
cin            { return(CIN); }
cout           { return(COUT); }


  /* comments */

^\/\/.*\n$     { /* comment */ }
^\#.*\n$       { /* comment */ }

  /* special characters */

\>\>            { return(RIGHT_OP); }
\<\<            { return(LEFT_OP); }
\&\&            { return(AND_OP); }
\|\|            { return(OR_OP); }
\<\=            { return(LE_OP); }
\>\=            { return(GE_OP); }
\=\=            { return(EQ_OP); }
\!\=            { return(NE_OP); }
\;              { return(SEMICOL); }
\{              { return(LB); }
\}              { return(RB); }
\,              { return(COL); }
\=              { return(EQ); }
\(              { return(LRB); }
\)              { return(RRB); }
\[              { return(LSB); }
\]              { return(RSB); }
\-              { return(MINUS); }
\+              { return(PLUS); }
\*              { return(TIMES); }
\/              { return(DIVIDE); }
\<              { return(GL); }
\>              { return(GR); }
\!              { return(NOT); }

{newline}       {
                  return( NEWLINE );
                }
{number}        {
                  return( NUMBER ); 
                }

{whitespace}    { /* skip */ }

{word}          {
                   return( STRINGLITERAL );
                }

{identifier}    {
                  return( IDENTIFIER );
                }

.              { /* skip */ }

<<EOF>>        {return ( END ) ;}

%%
