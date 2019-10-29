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
/* C string header, for string ops below */
#include <stdlib.h>
#include "mock_tokens.hh"

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

[\n]            {
                  return( NEWLINE );
                }
[\t\n]          {
                  return( NEWLINE );
               }

{number}       {
                  return( NUMBER ); 
               }

{whitespace}   { /* skip */ }

{word}         {
                   return( STRINGLITERAL );
               }

{identifier}   {
                  return( IDENTIFIER );
               }

.              { /* skip */ }

<<EOF>>        {return ( END ) ;}

%%

void printTokens(int token){
  printf("%d ",token);
}

void saveTokensToFile(int token, FILE* f){
  fprintf(f,"%d ", token);
}

void saveToFile(int token){
  fwrite( yytext, yyleng, 1, yyout);
}

void scan(void (*action)(int)){
  int token; 
  while(token = yylex()) {
    (*action)(token);
  }
}

void testScan(void (*action)(int)){
  int token;
  FILE* f = fopen("./test.out","w");
  while(token = yylex()) {
    fprintf(f,"%d ", token);
  }
  fclose(f);
}

void readFromFile(char* filename, void (*scan)(void (*action)(int)), void (*action)(int)){
  // set as input stream the file opened
  // yylex defaults to stdin if the yyin is not set
  if(!(yyin = fopen(filename, "r"))) {
      perror(filename);
      return;
  }
  // call the scan function with the action function as parameter
  (*scan)(*action);
}

void readMultipleFiles(int argc, char** argv, void (*scan)(void (*action)(int)), void (*action)(int)){
  int i;
  for(i = 1; i < argc; i++) {
    // open file
    FILE *f = fopen(argv[i], "r");

    if(!f) {
      perror(argv[i]);
      return;
    }
    // reset the lexer and set the input stream the file opened
    yyrestart(f);
    // call the scan function with the action function as parameter
    (*scan)(*action);
    fclose(f);
 }
}

void printHelpMenu(){
  printf("%s","<executable> -i - Read from the console.\n");
  printf("%s","<executable> -i <filename> - Read from the file\n");
  printf("%s","<executable> -i <filename1> <filename2> ... <filenameN> - Read from multiple files\n");
  printf("%s","<executable> -h - Displays the help menu\n");
  printf("%s","<executable> -h - Displays the help menu\n");

}

typedef struct Map{
  char*   key;
  char**  value;
  int     numberOfValues;
} Map;



int main(int argc, char** argv){
  // TODO - change function to accomodate multiple flags in any order 
  // int i,j, numberOfFlags = 0, flagsVisited = 0, positionOfFlags[argc];
  // for(i = 1; i < argc; i++){
  //   if(strchr(argv[i],'-')){
  //     positionOfFlags[numberOfFlags] = i;
  //     numberOfFlags++;
  //   }
  // }

  // // In order to not get an out of bound exception
  // positionOfFlags[numberOfFlags + 1] = argc - 1;

  // if(numberOfFlags != 0){
  //   Map map[numberOfFlags];
  //   for(i = 1; i < argc; i++){
  //     if(strchr(argv[i],'-')){
  //       flagsVisited++;
  //       int numberOfParameters = positionOfFlags[flagsVisited + 1] - positionOfFlags[flagsVisited] - 1;
  //       char** charArr;
  //       for(j = 0; j < numberOfParameters; j++){
  //         charArr[j] = "";
  //       }
  //       Map tempMap = {argv[i], charArr, 0};
  //       map[i] = tempMap;
  //     }else{
  //       map[i].value[map[i].numberOfValues] = argv[i];
  //       map[i].numberOfValues++;
  //     }
  //   }

  //   for(i = 0; i < numberOfFlags; i++){
  //     if(!strcmp(map[i].key,"-h")){
  //       printHelpMenu();
  //     }
  //   }
  // }else{
  //   printHelpMenu();
  // }

  if(argc == 1){
    scan(saveToFile);
  }
  if(argc == 2) {
    if(!strcmp(argv[1], "-h")){
      printHelpMenu();
    }else{
      readFromFile(argv[1],scan,printTokens);
    }
  }else{
    if(!strcmp(argv[1], "-t")){
      char* a = argv[0];
      char* b = argv[2];
      char[][] temp = {a,b};
      readMultipleFiles((argc - 1),temp,testScan,saveToFile);
    }
    readMultipleFiles(argc,argv,scan,printTokens);
  }
	return 0;
}