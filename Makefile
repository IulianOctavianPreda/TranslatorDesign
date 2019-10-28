CXX = gcc
# CXXDEBUG = -g -Wall
# CXXSTD = -std=c++14
CXXFLAGS = $(CXXDEBUG) $(CXXSTD)

BUILDPATH = ./build
SOBJ = lexer

all:
	$(MAKE) $(SOBJ)
	$(CXX) $(CXXFLAGS) ./build/lexer.o $(LIBS)

lexer: lexer.l
	flex -o ./lexer.yy.c ./lexer.l 
	$(CXX)  $(CXXFLAGS) ./lexer.yy.c -o $(BUILDPATH)/lexer.o -lfl
