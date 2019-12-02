CC    ?= gcc
CXX   ?= g++
EXE = C--

CDEBUG = -g -Wall
CXXDEBUG = -g -Wall

CSTD = -std=c99
CXXSTD = -std=c++17

CCFLAGS = $(CDEBUG) $(CSTD) 
CXXFLAGS = $(CXXDEBUG) $(CXXSTD)

COBJ  =  $(SOURCEPATH)/ast/ast 
FILES = $(addsuffix .c, $(COBJ))
OBJS  = $(addsuffix .o, $(COBJ))

SOURCEPATH = ./src
BUILDPATH = ./build
SOBJ = parser lexer


CLEANLIST = $(OBJS) \
			$(SOURCEPATH)/lexer/lex.yy.c $(SOURCEPATH)/parser/parser.tab.c $(SOURCEPATH)/parser/parser.tab.h\
			$(BUILDPATH)/lexer.o $(BUILDPATH)/parser.o

all:$(FILES)
	$(MAKE) $(SOBJ)
	$(MAKE) $(OBJS)
	$(CC) $(CCFLAGS) -o $(BUILDPATH)/$(EXE) $(BUILDPATH)/parser.o $(BUILDPATH)/lexer.o $(SOURCEPATH)/ast/ast.o $(LIBS)
	$(MAKE) clean

lexer: $(SOURCEPATH)/lexer/lexer.l 
	flex -o $(SOURCEPATH)/lexer/lex.yy.c $(SOURCEPATH)/lexer/lexer.l 
	$(CC) $(CCFLAGS) -c $(SOURCEPATH)/lexer/lex.yy.c -o $(BUILDPATH)/lexer.o

parser:  $(SOURCEPATH)/parser/parser.y
	bison -d $(SOURCEPATH)/parser/parser.y -o $(SOURCEPATH)/parser/parser.tab.c
	$(CC) $(CCFLAGS) -c -o $(BUILDPATH)/parser.o $(SOURCEPATH)/parser/parser.tab.c

clean:
	rm -rf $(CLEANLIST)

testy: $(SOURCEPATH)/test.cpp
	$(CXX) $(CXXFLAGS) $(SOURCEPATH)/test.cpp -o  $(SOURCEPATH)/testy -lstdc++fs

clean-testy: $(SOURCEPATH)/testy
	rm -rf $(SOURCEPATH)/testy