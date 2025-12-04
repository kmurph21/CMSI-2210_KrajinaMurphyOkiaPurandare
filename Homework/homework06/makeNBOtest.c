#include <stdio.h>
#include <stdint.h>
#include "whichendisup.h"
#include "makeNBOC.h"

int main() {
  printf("Checking system endianness...\n");
  if (isLittleEndian()){
    printf("This machine is little endian.\n");
  } else {
    printf("This machine is big endian.\n");
  }
  unit32_t original = 0x12345678;
  printf("Original value: 0x%08X\n", converted);
  return 0;
}
