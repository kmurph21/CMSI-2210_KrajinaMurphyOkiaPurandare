
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char*argv[]) {
  char input[25];
  printf("What is your name: ");
  scanf("%s", input);
  printf("\n Hello, %s\n", input);
  exit(0);
}
