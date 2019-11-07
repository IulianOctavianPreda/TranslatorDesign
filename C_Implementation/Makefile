CC    ?= gcc
CXX   ?= g++

CDEBUG = -g -Wall
CXXDEBUG = -g -Wall

CSTD = -std=c99
CXXSTD = -std=c++17

CCFLAGS = $(CDEBUG) $(CSTD) 
CXXFLAGS = $(CXXDEBUG) $(CXXSTD)

SOURCEPATH = ./src
BUILDPATH = ./build
SOBJ = lexer

all:
	$(MAKE) $(SOBJ)
	# clean

lexer: $(SOURCEPATH)/lexer/lexer.l
	flex -o $(SOURCEPATH)/lexer/lex.yy.c $(SOURCEPATH)/lexer/lexer.l 
	$(CC) $(CCFLAGS) $(SOURCEPATH)/lexer/lex.yy.c -lfl -o $(BUILDPATH)/lexer.out

clean:
	rm -rf lexer.yy.c lexer.yy.cc lex.yy.cc 

testy: $(SOURCEPATH)/test.cpp
	$(CXX) $(CXXFLAGS) $(SOURCEPATH)/test.cpp -o  $(SOURCEPATH)/testy -lstdc++fs

clean-testy: $(SOURCEPATH)/testy
	rm -rf $(SOURCEPATH)/testy