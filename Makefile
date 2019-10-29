CC    ?= gcc
CXX   ?= g++

CDEBUG = -g -Wall
CXXDEBUG = -g -Wall

CSTD = -std=c99
CXXSTD = -std=c++14

CFLAGS = $(CDEBUG) $(CSTD) 
CXXFLAGS = $(CXXDEBUG) $(CXXSTD)


BUILDPATH = ./build
SOBJ = lexer

all:
	$(MAKE) $(SOBJ)
	# clean

lexer: lexer.l
	flex lexer.l 
	$(CC)  $(CCFLAGS) lex.yy.c -lfl

clean:
	rm -rf lexer.yy.c lexer.yy.cc lex.yy.cc 

testy: test.cpp
	$(CXX) $(CXXFLAGS) test.cpp -o testy -lstdc++