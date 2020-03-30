#include "main.h"

void printTokens(int token) { printf("%d ", token); }

void saveTokensToFile(int token) { fprintf(yyout, "%d ", token); }

// void saveTextToFile(){
//   fwrite( yytext, yyleng, 1, yyout);
// }

void scan(void (*action)(int)) {
  int token;
  while (token = yylex()) {
    (*action)(token);
  }
}

void readFromFile(char* filename, void (*scan)(void (*action)(int)),
                  void (*action)(int)) {
  // set as input stream the file opened
  // yylex defaults to stdin if the yyin is not set
  if (!(yyin = fopen(filename, "r"))) {
    perror(filename);
    return;
  }
  // call the scan function with the action function as parameter
  (*scan)(*action);
}

void readMultipleFiles(int numberOfFiles, char** fileNames,
                       void (*scan)(void (*action)(int)), void (*action)(int)) {
  int i;
  for (i = 0; i < numberOfFiles; i++) {
    // open file
    printf("%s\n", fileNames[i]);
    FILE* f = fopen(fileNames[i], "r");

    if (!f) {
      perror(fileNames[i]);
      return;
    }
    // reset the lexer and set the input stream the file opened
    yyrestart(f);
    // call the scan function with the action function as parameter
    (*scan)(*action);
    fclose(f);
  }
}

char** copy_argv(char* argv[], int start, int end) {
  // calculate the contiguous argv buffer size
  int length = 0;
  size_t ptr_args = end - start + 1;
  for (int i = start + 1; i < end + 1; i++) {
    length += (strlen(argv[i]) + 1);
  }
  char** new_argv = (char**)malloc((ptr_args) * sizeof(char*) + length);
  // copy argv into the contiguous buffer
  length = 0;
  int k = 0;
  for (int i = start + 1; i < end + 1; i++) {
    new_argv[k] = &(((char*)new_argv)[(ptr_args * sizeof(char*)) + length]);
    strcpy(new_argv[k], argv[i]);
    length += (strlen(argv[i]) + 1);
    k++;
  }
  // insert NULL terminating ptr at the end of the ptr array
  new_argv[ptr_args - 1] = NULL;
  return (new_argv);
}

void printHelpMenu() {
  printf("%s",
         "Flags like -i -ap can be used together and are recommended to be "
         "used together\n");
  printf("%s", "The lexer defaults to print tokens to the console\n");
  printf("%s", "<executable> -h - Displays the help menu\n");
  printf("%s", "<executable> -i - Read from the console.\n");
  printf("%s", "<executable> -i <filename> - Read from the file\n");
  printf("%s",
         "<executable> -i <filename1> <filename2> ... <filenameN> - Read from "
         "multiple files\n");
  printf("%s",
         "<executable> -toFile <filename> - Saves the scanned tokens to the "
         "console\n");
}

int main(int argc, char** argv) {
  int i;
  if (argc == 1) {
    printHelpMenu();
  } else {
    void (*action)(int) = printTokens;
    void (*scanFunction)(void (*action)(int)) = scan;
    for (i = 1; i < argc; i++) {
      if (!strcmp(argv[i], "-h")) {
        printHelpMenu();
      }
      if (!strcmp(argv[i], "-i")) {
        int j = i;
        while (j + 1 < argc && strchr(argv[j + 1], '-') == NULL) {
          j++;
        }
        // j - i because we use 0 based index position
        if (j - i == 0) {
          (void)(*scanFunction)(*action);
        } else {
          if (j - i == 1) {
            for (i = 1; i < argc; i++) {
              if (!strcmp(argv[i], "-toFile")) {
                action = saveTokensToFile;
                if (i < argc) yyout = fopen(argv[i + 1], "w");
              }
            }
            readFromFile(argv[j], scanFunction, action);
          } else {
            for (i = 1; i < argc; i++) {
              if (!strcmp(argv[i], "-toFile")) {
                action = saveTokensToFile;
                if (i < argc) {
                  FILE* f = fopen(argv[i + 1], "w");
                  fclose(f);
                  yyout = fopen(argv[i + 1], "a");
                }
              }
            }
            char** filenames = copy_argv(argv, i, j);
            readMultipleFiles(j - i, filenames, scanFunction, action);
          }
        }
      }
    }
  }
  return 0;
}
