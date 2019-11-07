CC    ?= gcc
CXX   ?= g++

CDEBUG = -g -Wall
CXXDEBUG = -g -Wall

CSTD = -std=c99
CXXSTD = -std=c++14

CCFLAGS = $(CDEBUG) $(CSTD) 
CXXFLAGS = $(CXXDEBUG) $(CXXSTD)

SOBJ = parser

all:
	$(MAKE) $(SOBJ)
	$(MAKE) clean

parser: parser.y
	bison parser.y 
	$(CC) $(CCFLAGS) parser.tab.c

clean:
	rm -rf parser.tab.c

clean-parser:
	rm -rf a.out
