;6. Extra Credit PROBLEM: Finally, create a nasm or ARM program called makeNBON.nasm 
;or makeNBON.arm which does the byte order swapping BY CALLING YOUR C function from 
;problem five. Make your nasm or ARM program call the function at least five times 
;with different values to test it. The output of each test case should display on the 
;terminal window.

global main
extern makeNBO
extern printf

section .data
  fmtStr db "Input: 0x%08X -> NBO: 0x%08X", 10, 0

  val1 dd 0x11223344
  val2 dd 0xAABBCCDD
  val3 dd 0xDEADBEEF
  val4 dd 0x12345678
  val5 dd 0x00FF00FF

section .text

main:
  push rbp
  mov rbp, rsp
  
  ;Test1
  mov eax, [val1] ;load input
  mov edi, eax ;arg1=value -> makeNBO(value)
  call makeNBO ;result returned in eax
  mov esi, [val1] ;printf arg1
  mov edx, eax ;printf arg2 = result
  mov rdi, fmtStr ;printf(fmtStr, input, result)
  xor eax, eax
  call printf

  ;Test2
  mov eax, [val2]
  mov edi, eax
  call makeNBO
  mov esi, [val2]
  mov edx, eax
  mov rdi, fmtStr
  xor eax, eax
  call printf

  ;Test3
  mov eax, [val3]
  mov edi, eax
  call makeNBO
  mov esi, [val3]
  mov edx, eax
  mov rdi, fmtStr
  xor eax, eax
  call printf

  ;Test4
  mov eax, [val4]
  mov edi, eax
  call makeNBO
  mov esi, [val4]
  mov edx, eax
  mov rdi, fmtStr
  xor eax, eax
  call printf

  ;Test5
  mov eax, [val5]
  mov edi, eax
  call makeNBO
  mov esi, [val5]
  mov edx, eax
  mov rdi, fmtStr
  xor eax, eax
  call printf

  ;Exit
  mov rsp, rbp
  pop rbp
  mov eax, 0
  ret
