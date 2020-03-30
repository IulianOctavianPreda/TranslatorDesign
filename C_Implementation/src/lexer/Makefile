CC ?= gcc

CDEBUG = -g -Wall

CSTD = -std=c99

CCFLAGS = $(CDEBUG) $(CSTD) 

SOBJ = lexer

all:
	$(MAKE) $(SOBJ)
	$(MAKE) clean

lexer: lexer.l
	flex lexer.l 
	$(CC) $(CCFLAGS) main.c lex.yy.c -lfl

clean:
	rm -rf lex.yy.c

clean-lexer:
	rm -rf a.out
