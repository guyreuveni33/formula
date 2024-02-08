#206398596 Guy Reuveni
#208189126 Niv Swisa

all: part2.out

part2.out: main.o formula1.o formula2.o
	gcc -o part2.out main.o formula2.o formula1.o -lm

main.o: main.c
	gcc -c -o main.o main.c

formula2.o: formula2.s
	gcc -c -o formula2.o formula2.s
	
formula1.o: formula1.c
	gcc -msse4.2 -mavx -c -o formula1.o formula1.c

clean:
	rm -f *.o part2.out
