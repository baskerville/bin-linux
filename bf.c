#include <stdio.h>
#include <unistd.h>
#include <stdbool.h>
#include <string.h>

int main(void) {
    char cur[BUFSIZ] = {'\0'};
    char last[BUFSIZ] = {'\0'};
    int nb;
    while (true) {
        if ((nb = read(STDIN_FILENO, cur, sizeof(cur))) > 0) {
            cur[nb] = '\0';
            if (strcmp(cur, last) != 0) {
                write(STDOUT_FILENO, cur, nb);
                strcpy(last, cur);
            }
        }
    }
}
