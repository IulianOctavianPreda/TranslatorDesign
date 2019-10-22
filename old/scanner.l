%{
	#include <iostream>
	#include <cstdlib>
	#include "scanner.h"
	#include "interpreter.h"
	#include "parser.hpp"
	#include "location.hh"

	using namespace std;

	// Original yyterminate() macro returns int. Since we're using Bison 3 variants
	// as tokens, we must redefine it to change type from `int` to `Parser::semantic_type`
	#define yyterminate() CMM::Parser::make_END(CMM::location());

	// This will track current scanner location.
	// Action is called when length of the token is known.
	#define YY_USER_ACTION m_driver.increaseLocation(yyleng);
%}

%option nodefault
%option noyywrap
%option c++
%option yyclass="Scanner"
%option prefix="CMM_"

%%


[a-z]+      { 
                cout << "Scanner: identifier [" << yytext << "]" << endl;
                return CMM::Parser::make_STRING(yytext, CMM::location( /* put location data here if you want */ )); 
            }
            
\(          {
                cout << "Scanner: '('" << endl;
                return CMM::Parser::make_LEFTPAR(CMM::location());
            }
            
\)          { 
                cout << "Scanner: ')'" << endl;
                return CMM::Parser::make_RIGHTPAR(CMM::location());
            }
            
;           {
                cout << "Scanner: ';'" << endl;
                return CMM::Parser::make_SEMICOLON(CMM::location());
            }
            
,           {
                cout << "Scanner: ','" << endl;
                return CMM::Parser::make_COMMA(CMM::location());
            }
            
[\n\t ]     {
                //cout << "Scanner: whitechar (ignored)" << endl;
            }

[1-9][0-9]* {
                cout << "Scanner: decimal number: " << yytext << endl;
                uint64_t number = strtoull(yytext, 0, 10);
                return CMM::Parser::make_NUMBER(number, CMM::location());
            }

.           { 
                cout << "Scanner: unknown character [" << yytext << "]" << endl; 
            }
            
<<EOF>>     { return yyterminate(); }


%%
