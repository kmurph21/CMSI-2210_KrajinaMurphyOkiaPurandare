;5. Building on the previous problem, write a C function makeNBOC.c that takes a number as an argument, checks to see if the order needs 
;to be swapped to make Network Byte Order, and swaps its byte order, if necessary. Modify a copy of your previous program from problem 4, 
;whichendisup.c, to make a function that will determine the byte order and if it will need to be swapped. You can also research the hton() 
;and ntoh() functions to do the swapping [if you like]. Write a test program makeNBOtest.c to call your new function and display the results 
;of the function call on stdout using printf().

#ifndef MAKENBOC_H
#define MAKENBOC_H
  
#include <stdio.h>
#include <stdint.h>
#include "whichEndIsUp.h"

unit32_t makeNBO(unit32_t value){
  
  if(!isLittleEndian()){
    return value;
  }
  
  unit32_t byte0 = (value & 0x000000FF) << 24;
  unit32_t byte1 = (value & 0x0000FF00) << 8;
  unit32_t byte2 = (value & 0x00FF0000) >> 8;
  unit32_t byte3 = (value & 0xFF000000) >> 24;

  return (byte0 | byte1 | byte2 | byte3);
}

#endif
