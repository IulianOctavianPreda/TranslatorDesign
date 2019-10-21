# TranslatorDesign

Generate:

-   lexer with flex: main.exe 1
-   parser generator with bison: main.exe 2 /_provisory implementation as we don't have .y file yet_/
-   default: both lexer and parser /_provisory implementation as we don't have .y file yet_/

When updating main.cpp use:  
`g++ main.cpp -o main`

# Instructions

To build the lexer code use  
`flex ./lexer.l`

To build the executable  
`GCC ./lex.yy.c -lfl`

To use the executable  
`./a.out on linux`  
`./a.exe on windows`

It will then analyze anything you write into the console and for every match and action will be triggered

yywrap needs to be declared in the lexer.l or %noyywrap need to be present in it

# Project details

The project involves four main phases: scanning, parsing, semantic analysis and code generation (optionally).

Two extra credit points if the project contains the last phase (code generation).

## Scanning

One lexical analyser for the proposed language has to be constructed. The parser must detect the tokens of the language and report some lexical errors.

For a project having the type B or C, a scanner generator can be used (lex of Flex for C/C++ and JLex or JFlex for Java).

## Parsing

For a project having the type B or D, a parser for the proposed language has to be constructed. The parser has two main goals:

to check whether the input is a syntactically correct program, and
to generate an abstract syntax tree (AST) that records all important information about the program (the intermediate representation); to construct AST, some actions must to be added to the parser.
A parser generator can be used (yacc or Bison for C/C++ and CUP or JavaCC for Java).

## Semantic analysis

A two-pass static-semantic analyzer for the programs represented as abstract-syntax trees has to be constructed:

the name analysis method, and
type checking method.
The semantic analyzer will traverse the tree constructed in parsing phase to build a table of the symbols contained in the programs and to decorate AST with semantic information.

Name analysis perform several tasks, like: building symbol table, finding bad declarations, multiply declared names and uses of undeclared names, etc. They are used to generate useful error messages in this phase.

The job of the type checker is to determine the type of every expression in the abstract syntax tree and verify that the the type of each expression is appropriate for its context.

## Code generation (Optional)

Finally, the abstract syntax tree will be traversed again to perform final code generation. The code will be generated for a specified assembly language. The target language can be ASM (the assembly language for Intel processors) or Jasmin assembly language (for Java virtual machines).

Remark. Sun has not defined an assembler format for Java byte code. Jasmin is an assembly language for Java byte code. The assembler reads as input a Jasmin assembly program and produces as output a Java class file ready to be run on a JVM.

There are four types for project development:

A. Using C or C++ languages without lex/Flex or yacc/Bison.

B. Using C or C++ languages with lex/Flex or yacc/Bison.

C. Using Java languages without JLex/JFlex or CUP.

D. Using Java languages with JLex/JFlex or CUP.

More details in [C Minus Minus](./CMinusMinus.pdf)
