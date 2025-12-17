/*
In networking, it is necessary to make sure that bytes are transimitted in the proper order so the receiving device can interpret them
correctly. This requires that big-endian and little-endian values are converted to something called Network Byte Order before they are
transmitted. For this problem, write a C program whichEndIsUp.c that will determine whether your computer is big-endian or little-endian
as was discussed in class.
*/

#ifndef WHICHENDISUP_H
#define WHICHENDISUP_H

#include <stdio.h>      // fixed for you
#include <stdlib.h>     // fixed for you

int main() {
    unsigned int value = 1;
    unsigned char *bytePtr = (unsigned char *)&value;

    printf("Checking system endianness...\n");

    if (*bytePtr == 1) {
        printf("This machine is little-endian.\n");
    } else {
        printf("This machine is big-endian.\n");
    }

#endif

    return 0;
}
