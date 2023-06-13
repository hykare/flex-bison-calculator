# z .bat
# bison -d calc.y
# flex calc.l
# gcc calc.tab.c lex.yy.c -o calc -lm
# ./calc

# eksperymenty
calc: calc.l calc.y
			bison -d calc.y
			flex calc.l
			gcc -o $@ calc.tab.c lex.yy.c -lfl -lm



# calc z wiki

# FILES = lexer.c parser.c expression.c main.c
# CC = gcc
# CFLAGS = -g -ansi

# test: $(FILES)
# 	$(CC) $(CFLAGS) $(FILES) -o test

# lexer.c: lexer.l
# 	flex lexer.l

# parser.c: parser.y lexer.c
# 	bison parser.y

# clean:
# 	rm -f *.o *~ lexer.c lexer.h parser.c parser.h test