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
	
	/* Reserved keywords*/

"int"			{ count(); return(INT); }
"bool" 			{ count(); return(BOOL); }
"void"			{ count(); return(VOID); }
"true"			{ count(); return(TRUE); }
"false"			{ count(); return(FALSE); }
"if"			{ count(); return(IF); }
"else"			{ count(); return(ELSE); }
"while"			{ count(); return(WHILE); }
"return"		{ count(); return(RETURN); }
"cin"			{ count(); return(CIN); }
"cout"			{ count(); return(COUT); }

  /* comments */

"/*"			{ comment(); }
"//"[^\n]*      { /* comment */ }
"#"[^\n]*       { /* comment */ }

  /* special characters */

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
.				{ fprintf(stderr, "MISS MATCH: %c\n", yytext[0]); }


{number} {
	yylval.value = atoi(yytext); 
	return NUMBER;
}

{whitespace} {/* skip */}

[\t\n]		{ count(); }

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


