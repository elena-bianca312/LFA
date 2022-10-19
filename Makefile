# Dumitru Elena-Bianca 331CC
build:
	flex tema.l
	gcc lex.yy.c -o tema
run:
	./tema in1.txt
clean:
	rm tema lex.yy.c