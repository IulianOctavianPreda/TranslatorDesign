CXX = g++
EXE = C--
CXXDEBUG = -g -Wall
CXXSTD = -std=c++14
CXXFLAGS = $(CXXDEBUG) $(CXXSTD)

SOURCEPATH = ./src
BUILDPATH = ./build

CPPOBJ = $(SOURCEPATH)/main $(SOURCEPATH)/driver/cmm_driver
SOBJ =  parser lexer

FILES = $(addsuffix .cpp, $(CPPOBJ))

OBJS  = $(addsuffix .o, $(CPPOBJ))

CLEANLIST = $(OBJS) \
			$(SOURCEPATH)/parser/cmm_parser.tab.cc $(SOURCEPATH)/parser/cmm_parser.tab.hh \
			$(SOURCEPATH)/parser/location.hh $(SOURCEPATH)/parser/position.hh \
			$(SOURCEPATH)/parser/stack.hh $(SOURCEPATH)/parser/cmm_parser.output $(BUILDPATH)/parser.o \
			$(BUILDPATH)/lexer.o $(SOURCEPATH)/scanner/cmm_lexer.yy.cc\

all:$(FILES)
	$(MAKE) $(SOBJ)
	$(MAKE) $(OBJS)
	$(CXX) $(CXXFLAGS) -o $(BUILDPATH)/$(EXE) $(OBJS) $(BUILDPATH)/parser.o $(BUILDPATH)/lexer.o $(LIBS)
	$(MAKE) clean

parser: $(SOURCEPATH)/parser/cmm_parser.yy
	bison -d -v $(SOURCEPATH)/parser/cmm_parser.yy -o $(SOURCEPATH)/parser/cmm_parser.tab.cc
	$(CXX) $(CXXFLAGS) -c -o $(BUILDPATH)/parser.o $(SOURCEPATH)/parser/cmm_parser.tab.cc

lexer: $(SOURCEPATH)/scanner/cmm_lexer.l
	flex -o $(SOURCEPATH)/scanner/cmm_lexer.yy.cc $(SOURCEPATH)/scanner/cmm_lexer.l
	$(CXX)  $(CXXFLAGS) -c $(SOURCEPATH)/scanner/cmm_lexer.yy.cc -o $(BUILDPATH)/lexer.o

clean:
	rm -rf $(CLEANLIST)