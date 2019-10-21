digit       [0-9]
number      {digit}+
letter      [a-zA-Z]
identifier  (_|{letter})({letter}|{digit}|_)*
newline     \n
tab			\t
string      "((\\")|(\\')|(\\\\)|(\\n)|(\\t)|&|!|#|[a-zA-Z]|[0-9]|_)*"
whitespace  [ ]

%{

#include <stdio.h>
#include "y.tab.h"
void count(void);

%}

%%
	



"/*"			{ comment(); }
"//"[^\n]*      { /* comment */ }
"#"[^\n]*       { /* comment */ }
bool 			{ count(); return(BOOL); }
"else"			{ count(); return(ELSE); }
"if"			{ count(); return(IF); }
"int"			{ count(); return(INT); }
"return"		{ count(); return(RETURN); }
"void"			{ count(); return(VOID); }
"while"			{ count(); return(WHILE); }
">>"			{ count(); return(RIGHT_OP); }
"<<"			{ count(); return(LEFT_OP); }
"&&"			{ count(); return(AND_OP); }
"||"			{ count(); return(OR_OP); }
"<="			{ count(); return(LE_OP); }
">="			{ count(); return(GE_OP); }
"=="			{ count(); return(EQ_OP); }
"!="			{ count(); return(NE_OP); }
";"				{ count(); return(';'); }
("{"|"<%")		{ count(); return('{'); }
("}"|"%>")		{ count(); return('}'); }
","				{ count(); return(','); }
"="				{ count(); return('='); }
"("				{ count(); return('('); }
")"				{ count(); return(')'); }
("["|"<:")		{ count(); return('['); }
("]"|":>")		{ count(); return(']'); }
"-"				{ count(); return('-'); }
"+"				{ count(); return('+'); }
"*"				{ count(); return('*'); }
"/"				{ count(); return('/'); }
"<"				{ count(); return('<'); }
">"				{ count(); return('>'); }


{number} {
	yylval.value = atoi(yytext); 
	return NUMBER;
}

{whitespace} {/* skip */}

[ \t\n]		{ count(); }
.			{fprintf(stderr, "MISS MATCH: %c\n", yytext[0]);}
{identifier} {
	yylval.name = strdup(yytext); /*Returns a pointer to a null-terminated byte string, which is a 
								 duplicate of the string pointed to by str1. The returned pointer must 
								 be passed to free to avoid a memory leak. */
	return ID;
}

%%

int yywrap(void)
{
	return 1;
}

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

int column = 0;

void count(void)
{
	int i;
	for (i = 0; yytext[i] != '\0'; i++)
		if (yytext[i] == '\n')
			column = 0;
		else if (yytext[i] == '\t')
			column += 8 - (column % 8);
		else
			column++;
	ECHO;
}


