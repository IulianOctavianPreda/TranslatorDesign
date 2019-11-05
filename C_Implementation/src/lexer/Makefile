CC    ?= gcc
CXX   ?= g++

CDEBUG = -g -Wall
CXXDEBUG = -g -Wall

CSTD = -std=c99
CXXSTD = -std=c++14

CCFLAGS = $(CDEBUG) $(CSTD) 
CXXFLAGS = $(CXXDEBUG) $(CXXSTD)

SOBJ = lexer

all:
	$(MAKE) $(SOBJ)
	clean

lexer: lexer.l
	flex lexer.l 
	$(CC) $(CCFLAGS) lex.yy.c -lfl

clean:
	rm -rf lex.yy.c
