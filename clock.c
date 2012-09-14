#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <time.h>

#define MAXLEN 256

int main(int argc, char *argv[])
{
    char **args = argv + 1;
    int num_args = argc - 1;

    if (num_args != 2) {
        fprintf(stderr, "usage: %s FORMAT INTERVAL\n", argv[0]);
        return -1;
    }

    char *format = *args;
    int interval = atoi(*(args + 1));

    if (interval < 1) {
        fprintf(stderr, "error: the sleep interval must be > 0\n");
        return -1;
    }

    char last_output[MAXLEN], output[MAXLEN];
    time_t t;
    struct tm *tmp;

    while (1) {
        t = time(NULL);
        tmp = localtime(&t);
        strftime(output, MAXLEN, format, tmp);
        if (strcmp(output, last_output) != 0) {
            printf("%s", output);
            fflush(stdout);
        }
        strcpy(last_output, output);
        sleep(interval);
    }

    return 0;
}
