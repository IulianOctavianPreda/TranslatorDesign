CXX = g++
EXE = C--
CXXDEBUG = -g -Wall
CXXSTD = -std=c++14
CXXFLAGS = -Wno-deprecated-register -O0  $(CXXDEBUG) $(CXXSTD)

SOURCEPATH = ./src
BUILDPATH = ./build

CPPOBJ = $(SOURCEPATH)/main $(SOURCEPATH)/driver/cmm_driver
SOBJ =  parser lexer

FILES = $(addsuffix .cpp, $(CPPOBJ))

OBJS  = $(addsuffix .o, $(CPPOBJ))

# CLEANLIST =  $(addsuffix .o, $(OBJ)) $(OBJS) \
# 				 cmm_parser.tab.cc cmm_parser.tab.hh \
# 				 location.hh position.hh \
# 			    stack.hh cmm_parser.output parser.o \
# 				 lexer.o cmm_lexer.yy.cc $(EXE)\

all: 
	$(FILES)
	$(MAKE) $(SOBJ)
	$(MAKE) $(OBJS)
	$(CXX) $(CXXFLAGS) -o $(EXE) $(OBJS) parser.o lexer.o $(LIBS)


parser: $(SOURCEPATH)/parser/cmm_parser.yy
	bison -d -v $(SOURCEPATH)/parser/cmm_parser.yy -o $(BUILDPATH)/cmm_parser.tab.cc
	$(CXX) $(CXXFLAGS) -c -o $(BUILDPATH)/parser.o $(BUILDPATH)/cmm_parser.tab.cc

lexer: $(SOURCEPATH)/scanner/cmm_lexer.l
	flex -o $(BUILDPATH)/cmm_lexer.yy.cc $(SOURCEPATH)/scanner/cmm_lexer.l $<
	$(CXX)  $(CXXFLAGS) -c $(BUILDPATH)/cmm_lexer.yy.cc -o $(BUILDPATH)/lexer.o

# clean:
# 	rm -rf $(CLEANLIST)