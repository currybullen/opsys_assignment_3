CC=gcc
CFLAGS=-gcc -std=c99 -Wall -pthread
SRC=src
TARGET=target

make:
	$(CC) -pthread $(SRC)/seq_writes.c -o $(TARGET)/seq_writes

clean:
	rm $(TARGET)/seq_writes
