tp: transpose.o calltranspose.o
	gcc transpose.o calltranspose.o -g -o tp

transpose.o: transpose.asm
	nasm -felf64 -F dwarf -g transpose.asm 

calltranspose.o: calltranspose.c
	gcc -c -g calltranspose.c -Wall

clean:
	rm *.o tp *~

test: tp
	./tp
