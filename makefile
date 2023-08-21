highlow: getGuess.o getRandom.o main.o
	gcc -o highlow getGuess.o getRandom.o main.o
getGuess.o: getGuess.s
	gcc -c getGuess.s
getRandom.o: getRandom.s
	gcc -c getRandom.s
main.o: main.s
	gcc -c main.s
clean:
	rm *.o highlow
