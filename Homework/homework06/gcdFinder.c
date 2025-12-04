#include <stdio.h>
#include <stdint.h>
#include <assert.h>

unit64_t gcd(unit64_t a, unit64_t b);

int main() {
  unit64_t a = 3113041662ULL;
  unit64_t b = 11570925ULL;
  unit64_t result = gcd(a, b);

  printf("GCD(%llu, %llu) = %llu\n", (unisigned long long)a, (unisnged long long)b, (unsigned long long)result);
 
  assert(result == 462837ULL);
  assert(gcd(10, 5)==5);
  assert(gcd(21, 14)==7);
  assert(gcd(100, 1)==1);
  assert(gcd(0, 5)==5);
  assert(gcd(5, 0)==5);

  print("All tests passed!\n");
  return 0;
}
      
