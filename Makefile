CC=gcc
CFLAGS=-gcc -std=c99 -Wall -pthread
SRC=src
TARGET=target

make:
	$(CC) -pthread $(SRC)/par_writes.c -o $(TARGET)/par_writes

clean:
	rm $(TARGET)/par_writes
