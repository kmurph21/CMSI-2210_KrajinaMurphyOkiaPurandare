#include <stdio.h>
#include <time.h>

int main() {
    time_t start, end;

    printf("This program will time how long you can hold your breath.\n");
    printf("Take a deep breath, then press Enter to begin.\n");
    getchar(); 

    start = time(NULL);

    printf("Keep goign but if you absolutely cannot anymore press ENTER again when you exhale.\n");
    getchar(); 

    end = time(NULL);

    printf("You held your breath for %ld seconds.\n", end - start);

    return 0;
}
