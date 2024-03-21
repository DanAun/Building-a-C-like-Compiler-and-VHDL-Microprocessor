all: out

parser.tab.c parser.tab.h: parser.y
	bison -t -v -d parser.y

lex.yy.c: lex.l
	flex lex.l

out: lex.yy.c parser.tab.c parser.tab.h
	gcc -o out parser.tab.c lex.yy.c

clean:
	rm out lex.yy.c parser.tab.c parser.tab.h

test: all
	echo "Running test...\n"
	./out < ./tests/testfile2.c