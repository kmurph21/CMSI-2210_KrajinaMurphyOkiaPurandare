#include<stdio.h>
#include<stdlib.h>
int main(int argc, char *argv[]) {
  unisgned int num;
  if (argc==2) {
    num=(unsigned int)atoi(argv[1]);
  }
  else {
    printf("Enter a base 10 number:");
    scanf("%u", &num);
  }
  char binary[33];
  binary[32]='\0';
  for(int i=31; i>=0; i--) {
    binary[i]=num(num&1)?'1':'0';
    num>>=1;
  }
  printf("%s\n", binary);
  return 0;
}
