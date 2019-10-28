CXX = gcc
# CXXDEBUG = -g -Wall
# CXXSTD = -std=c++14
CXXFLAGS = $(CXXDEBUG) $(CXXSTD)

BUILDPATH = ./build
SOBJ = lexer

all:
	$(MAKE) $(SOBJ)
	# $(CXX) $(CXXFLAGS) ./build/lexer.o $(LIBS)
	# clean

lexer: lexer.l
	flex lexer.l 
	$(CXX)  $(CXXFLAGS) lex.yy.c -lfl

clean:
	rm -rf lexer.yy.c lexer.yy.cc lex.yy.cc 