#include <stdio.h>

int main(int argc, char *argv[]) {

    FILE *file;
    int ch;
    int word_count = 0;
    int inside_word = 0;

   
    if (argc != 2) {
        printf("Usage: %s <filename>\n", argv[0]);
        return 1;
    }
    file = fopen(argv[1], "r");
    if (file == NULL) {
        printf("Error: Could not open file.\n");
        return 1;
    }

    while ((ch = fgetc(file)) != EOF) {
        if (ch == ' ' || ch == '\n' || ch == '\t') {
            inside_word = 0;
        } else {
            if (inside_word == 0) {
                word_count++;
                inside_word = 1;
            }
        }
    }

    fclose(file);

    printf("Number of words: %d\n", word_count);

    return 0;
}
