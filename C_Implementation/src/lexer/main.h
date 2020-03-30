#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
extern FILE* yyin;
extern FILE* yyout;
extern void yyrestart(FILE*);

void printTokens(int token);
void saveTokensToFile(int token);
void scan(void (*action)(int));
void readFromFile(char* filename, void (*scan)(void (*action)(int)),
                  void (*action)(int));
void readMultipleFiles(int numberOfFiles, char** fileNames,
                       void (*scan)(void (*action)(int)), void (*action)(int));
char** copy_argv(char* argv[], int start, int end);
void printHelpMenu();