#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Usage: %s <N>\n", argv[0]);
        return 1;
    }

    int N = atoi(argv[1]); // turn command-line argument into an integer

    printf("Times Tables from 2 to %d:\n\n", N);

    
    for (int i = 1; i <= 12; i++) {
        for (int j = 2; j <= N; j++) {
            printf("%4d", i * j); // print each product in its own column
        }
        printf("\n"); // new line after each row
    }

    return 0;
}

