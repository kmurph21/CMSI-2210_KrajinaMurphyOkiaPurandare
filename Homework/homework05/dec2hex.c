#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]){
    unsigned long long num;
    int digits = 8;

    if(argc >= 2){
        num = strtoull(argv[1], NULL, 10);
        if(argc == 3){
            digits = atoi(argv[2]);
        }
    } else{
        printf("Enter a base-10 number: ");
        scanf("%llu", &num);
        printf("Enter number of hex digits (8 or 16): ");
        scanf("%d", &digits);
    }

    if(digits == 16){
        printf("Hex (64-bit): 0x%016llx\n", num);
    } else{
        printf("Hex (32-bit): 0x%08llx\n", num);
    }

    return 0;

}
