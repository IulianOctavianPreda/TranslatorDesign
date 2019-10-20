D			[0-9]
L			[a-zA-Z_]
H			[a-fA-F0-9]
E			([Ee][+-]?{D}+)
P           ([Pp][+-]?{D}+)
FS			(f|F|l|L)
IS          ((u|U)|(u|U)?(l|L|ll|LL)|(l|L|ll|LL)(u|U))

%{
#include <stdio.h>
#include "y.tab.h"
void count(void);
%}
%%
[0-9]+          return NUMBER;
"/*"			{ comment(); }
"//"[^\n]*      { /* consume //-comment */ }
"#"[^\n]*       { /* consume //-comment */ }
"_Bool"			{ count(); return(BOOL); }
"else"			{ count(); return(ELSE); }
"if"			{ count(); return(IF); }
"int"			{ count(); return(INT); }
"return"		{ count(); return(RETURN); }
"void"			{ count(); return(VOID); }
"while"			{ count(); return(WHILE); }

{L}({L}|{D})*		{ count(); return(check_type()); }
0[xX]{H}+{IS}?		{ count(); return(CONSTANT); }
0[0-7]*{IS}?		{ count(); return(CONSTANT); }
[1-9]{D}*{IS}?		{ count(); return(CONSTANT); }
L?'(\\.|[^\\'\n])+'	{ count(); return(CONSTANT); }
{D}+{E}{FS}?		{ count(); return(CONSTANT); }
{D}*"."{D}+{E}?{FS}?	{ count(); return(CONSTANT); }
{D}+"."{D}*{E}?{FS}?	{ count(); return(CONSTANT); }
0[xX]{H}+{P}{FS}?	{ count(); return(CONSTANT); }
0[xX]{H}*"."{H}+{P}?{FS}?     { count(); return(CONSTANT); }
0[xX]{H}+"."{H}*{P}?{FS}?     { count(); return(CONSTANT); }
L?\"(\\.|[^\\"\n])*\"	{ count(); return(STRING_LITERAL); }\

">>"			{ count(); return(RIGHT_OP); }
"<<"			{ count(); return(LEFT_OP); }

"&&"			{ count(); return(AND_OP); }

"||"			{ count(); return(OR_OP); }

"<="			{ count(); return(LE_OP); }

">="			{ count(); return(GE_OP); }

"=="			{ count(); return(EQ_OP); }

"!="			{ count(); return(NE_OP); }

";"			{ count(); return(';'); }

("{"|"<%")		{ count(); return('{'); }

("}"|"%>")		{ count(); return('}'); }

","			{ count(); return(','); }


"="			{ count(); return('='); }

"("			{ count(); return('('); }

")"			{ count(); return(')'); }

("["|"<:")		{ count(); return('['); }

("]"|":>")		{ count(); return(']'); }

"-"			{ count(); return('-'); }

"+"			{ count(); return('+'); }

"*"			{ count(); return('*'); }

"/"			{ count(); return('/'); }

"<"			{ count(); return('<'); }

">"			{ count(); return('>'); }

[ \t\v\n\f]		{ count(); }

.			{ /* Add code to complain about unmatched characters */ }

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


static int check_type(void)
{
    switch (sym_type(yytext))
    {
    case TYPEDEF_NAME:                /* previously defined */
        return TYPEDEF_NAME;
    case ENUMERATION_CONSTANT:        /* previously defined */
        return ENUMERATION_CONSTANT;
    default:                          /* includes undefined */
        return IDENTIFIER;
    }
}