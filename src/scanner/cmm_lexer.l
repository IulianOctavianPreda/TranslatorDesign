digit       [0-9]
number      {digit}+
letter      [a-zA-Z]
word        {letter}+
identifier  (_|{letter})({letter}|{digit}|_)*
newline     \n
tab			\t
string      "((\\")|(\\')|(\\\\)|(\\n)|(\\t)|&|!|#|[a-zA-Z]|[0-9]|_)*"
whitespace  [ ]

%{
/* C++ string header, for string ops below */
#include <string>

/* Implementation of yyFlexScanner */ 
#include "cmm_scanner.hpp"
#undef  YY_DECL
#define YY_DECL int CMM::CMM_Scanner::yylex( CMM::CMM_Parser::semantic_type * const lval, CMM::CMM_Parser::location_type *loc )

/* typedef to make the returns for the tokens shorter */
using token = CMM::CMM_Parser::token;

/* define yyterminate as this instead of NULL */
#define yyterminate() return( token::END )

/* update location on matching */
#define YY_USER_ACTION loc->step(); loc->columns(yyleng);

%}

%option debug
%option nodefault
%option yyclass="CMM::CMM_Scanner"
%option noyywrap
%option c++

%%

%{          
   /** Code executed at the beginning of yylex **/
   yylval = lval;
%}
		
	/* Reserved keywords*/

"int"			   { return(token::INT); }
"bool" 			{ return(token::BOOL); }
"void"			{ return(token::VOID); }
"true"			{ return(token::TRUE); }
"false"			{ return(token::FALSE); }
"if"			   { return(token::IF); }
"else"			{ return(token::ELSE); }
"while"			{ return(token::WHILE); }
"return"		   { return(token::RETURN); }
"cin"			   { return(token::CIN); }
"cout"			{ return(token::COUT); }


  /* comments */

"/*"			    { comment(); }
"//"[^\n]*      { /* comment */ }
"#"[^\n]*       { /* comment */ }

  /* special characters */

">>"			   { return(token::RIGHT_OP); }
"<<"			   { return(token::LEFT_OP); }
"&&"			   { return(token::AND_OP); }
"||"			   { return(token::OR_OP); }
"<="			   { return(token::LE_OP); }
">="			   { return(token::GE_OP); }
"=="			   { return(token::EQ_OP); }
"!="			   { return(token::NE_OP); }
";"				{ return(token::SEMICOL); }
("{"|"<%")		{ return(token::LB); }
("}"|"%>")		{ return(token::RB); }
","				{ return(token::COL); }
"="				{ return(token::EQ); }
"("				{ return(token::LRB); }
")"				{ return(token::RRB); }
("["|"<:")		{ return(token::LSB); }
("]"|":>")		{ return(token::RSB); }
"-"				{ return(token::MINUS); }
"+"				{ return(token::PLUS); }
"*"				{ return(token::TIMES); }
"/"				{ return(token::DIVIDE); }
"<"				{ return(token::GL); }
">"				{ return(token::GR); }

\n		         {
                  // Update line number
                  loc->lines();
                  return( token::NEWLINE );
               }

{number}       {
                  yylval.value = stoi(yytext);
                  return( token::NUMBER ); 
               }

{whitespace}   { /* skip */ }

{word}         {
	          yylval->build< std::string >( yytext );
	          return( token::STRINGLITERAL );
               }

{identifier}   {
                  yylval->build< std::string >( yytext );
                  return( token::IDENTIFIER );
               }

.              { charMissmatch(); }

%%


void comment(void)
{
	char c, prev = 0;
	while ((c = input()) != 0)      /* (EOF maps to 0) */
	{
		if (c == '/' && prev == '*')
			return;
		prev = c;
	}
	error("unterminated comment");
}

void charMissmatch(){
   cout << "MISS MATCH:" << yytext[0] << endl;
}
