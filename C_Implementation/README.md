# Instructions

To build the lexer code use  
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

It will then analyze anything you write into the console and for every match and action will be triggered

yywrap needs to be declared in the lexer.l or %noyywrap need to be present in it
