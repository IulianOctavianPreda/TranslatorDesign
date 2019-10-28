digit       [0-9]
number      {digit}+
letter      [a-zA-Z]
word        {letter}+
identifier  (_|{letter})({letter}|{digit}|_)*
newline     [\n]
tab         [\t]
string      "((\\)|(\")|(\\\")|(\\')|(\\\')|(\\\\)|(\\n)|(\\t)|&|!|#|[a-zA-Z]|[0-9]|_)*"
whitespace  [ ]

%{
/* C++ string header, for string ops below */
#include <iostream>
#include "mock_tokens.hh"

/* define yyterminate as this instead of NULL */
#define yyterminate() return( token::END )

%}
%option debug
%option nodefault
%option noyywrap
%option c++

%%

%{          
   int yylval;
%}
        
    /* Reserved keywords*/

int            { return(token::INT); }
bool           { return(token::BOOL); }
void           { return(token::VOID); }
true           { return(token::TRUE); }
false          { return(token::FALSE); }
if             { return(token::IF); }
else           { return(token::ELSE); }
while          { return(token::WHILE); }
return         { return(token::RETURN); }
cin            { return(token::CIN); }
cout           { return(token::COUT); }


  /* comments */

^\/\/.*\n$     { /* comment */ }
^\#.*\n$       { /* comment */ }

  /* special characters */

\>\>            { return(token::RIGHT_OP); }
\<\<            { return(token::LEFT_OP); }
\&\&            { return(token::AND_OP); }
\|\|            { return(token::OR_OP); }
\<\=            { return(token::LE_OP); }
\>\=            { return(token::GE_OP); }
\=\=            { return(token::EQ_OP); }
\!\=            { return(token::NE_OP); }
\;              { return(token::SEMICOL); }
\{              { return(token::LB); }
\}              { return(token::RB); }
\,              { return(token::COL); }
\=              { return(token::EQ); }
\(              { return(token::LRB); }
\)              { return(token::RRB); }
\[              { return(token::LSB); }
\]              { return(token::RSB); }
\-              { return(token::MINUS); }
\+              { return(token::PLUS); }
\*              { return(token::TIMES); }
\/              { return(token::DIVIDE); }
\<              { return(token::GL); }
\>              { return(token::GR); }

[\n]            {
                  return( token::NEWLINE );
                }
[\t\n]          {
                  return( token::NEWLINE );
               }

{number}       {
                  return( token::NUMBER ); 
               }

{whitespace}   { /* skip */ }

{word}         {
                   return( token::STRINGLITERAL );
               }

{identifier}   {
                  return( token::IDENTIFIER );
               }

.              { /* skip */ }

%%

int main(){
	FlexLexer* lexer = new yyFlexLexer;
	int tok;
 	while(tok = lexer->yylex()) {
 		std::cout << tok;
	}
	return 0;
}