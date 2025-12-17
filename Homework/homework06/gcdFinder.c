#include <stdio.h>
#include <stdint.h>
#include <assert.h>

// you misspelled "uint64_t" as "uint64_t"
// I made the changes for you since I could do a
//    global search and replace

uint64_t gcd(uint64_t a, uint64_t b);

int main() {
  uint64_t a = 3113041662ULL;
  uint64_t b = 11570925ULL;
  uint64_t result = gcd(a, b);

// you misspelled "unsigned" as "unsigned" or "unisinged"
// I made the changes for you since I could do a
//    global search and replace
  printf("GCD(%llu, %llu) = %llu\n", (unsigned long long)a, (unsigned long long)b, (unsigned long long)result);

  assert(result == 462837ULL);
  assert(gcd(10, 5)==5);
  assert(gcd(21, 14)==7);
  assert(gcd(100, 1)==1);
  assert(gcd(0, 5)==5);
  assert(gcd(5, 0)==5);

// you misspelled "printf" as "print"
// I made the changes for you since I could do a
//    global search and replace
  printf("All tests passed!\n");
  return 0;
}

