#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <time.h>
#include <fcntl.h>
#include <unistd.h>

int NUM_FILES;
int SIZE;
int NUM_THREADS;
char *DESTINATION_DIR;
int BUF_SIZE;

int COUNTER;
pthread_mutex_t LOCK;

void *perform_writes(void *args);
void perform_write(char *path);

int main(int argc, char *argv[]) {
    NUM_FILES = strtol(argv[1], NULL, 0);
    SIZE = strtol(argv[2], NULL, 0);
    NUM_THREADS = strtol(argv[3], NULL, 0);
    DESTINATION_DIR = argv[4];
    BUF_SIZE = strtol(argv[5], NULL, 0);

    pthread_t tid[NUM_THREADS];
    for (int i = 0; i < NUM_THREADS; i++) {
        pthread_create(&(tid[i]), NULL, &perform_writes, NULL);
    }

    for (int i = 0; i < NUM_THREADS; i++) {
        pthread_join(tid[i], NULL);
    }
}

void *perform_writes(void *args) {
    while (1) {
        int file_num;
        char path[100];

        pthread_mutex_lock(&LOCK);
        file_num = COUNTER++;
        pthread_mutex_unlock(&LOCK);

        if (file_num >= NUM_FILES)
            pthread_exit(NULL);

        sprintf(path, "%s/%d", DESTINATION_DIR, file_num);
        perform_write(path);
    }
}

void perform_write(char *path) {
    clock_t start, end;
    int src, dst;
    char buf[BUF_SIZE];
    int remaining = SIZE;
    int read_size;

    start = clock();
    src = open("/dev/zero", O_RDONLY);
    dst = open(path, O_WRONLY | O_CREAT, 0644);
    while (remaining > 0) {
        read_size = (remaining < BUF_SIZE) ? remaining: BUF_SIZE;
        read(src, buf, read_size);
        write(dst, buf, read_size);
        remaining -= read_size;
    }

    close(src);
    close(dst);
    end = clock();
    printf("%f\n", (double) (end - start));
}
