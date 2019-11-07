# Instructions

## For the stand-alone lexer 
Open a terminal in the lexer folder  

To build the lexer code and  use  
`flex ./lexer.l`

To build the executable  
`GCC ./lex.yy.c -lfl`

Alternatively if you have make installed you can use  
`make`  
or  
`make -f <makefile name>` if you want to make your own makefile

To use the executable  
`./a.out on linux`  
`./a.exe on windows`

### Arguments for the lexer

    Flags like -i -ap can be used together and are recommended to be used together
    The lexer defaults to print tokens to the console
    <executable> -h - Displays the help menu
    <executable> -i - Read from the console.
    <executable> -i <filename> - Read from the file
    <executable> -i <filename1> <filename2> ... <filenameN> - Read from multiple files
    <executable> -ap - Prints the scanned tokens to the console
    <executable> -as <filename> - Saves the scanned tokens to the console

### Tests 

In the src folder you can use the test.cpp to run various test.
It accepts the following arguments:

    -lex <folder path to lexer> - to run all lexer tests
    -lex <folder path to lexer> <filename> - to run a specific lexer test
