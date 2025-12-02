;--------------------------------------------
;Using a previous homework problem with code from our stanley/penguin language as 
;your guide, write an assembly program using nasm or ARM called findGCD.nasm or 
;findGCD.arm which will find the GCD of the two numbers. Test your program using 
;the numbers 3113041662 and 11570925 which should produce the value 462837. Read the 
;two numbers from the keyboard at port stdin and write the result to port stdout.
;--------------------------------------------

global _start

section .bss
  buffer resb 64 ; input / temporary buffer
  a resq 1 ;store first number
  b resq 1 ;store second number

section .text
;--------------------------------------------
;read_integer
;reads one ASCII non negative integer from stdin (stops at newline or whitespace)
;returns: RAX = parsed unsigned 64 bit value
;clobbers: RDI, RSI, RDX, R8, R9, R10, R11, RBX
;--------------------------------------------
read_integer:
  ;syscall: read(0, buffer, 64)
  mov rax, 0 ;sys_read
  mov rdi, 0 ;stdin
  lea rsi, [rel buffer] 
  mov rdx, 64
  syscall
  ;rax = number of bytes read(0=E0F, negative = error)
  cmp rax, 0
  jle .ri_return_zero ;if 0 or error, return 0
  mov rcx, rax ;rcx = bytes read
  xor rbx, rbx ;rbx = accumulator
  xor r8, r8 ;r8 = index

.ri_parse_loop:
  cmp r8, rcx
  jae .ri_done ;reached end of read buffer
  movzx rdx, byte [buffer + r8] ;rdx = current char
  cmp dl. 0x0A ;newline
  je .ri_done
  cmp dl, 0x0D ;carriage return
  je .ri_done
  cmp dl, '' ;space
  je .ri_done
  cmp dl, 9 ;tab
  je .ri_done
  ;skip any leading spaces
  ;if this is a leading whitespace then skip
  ;but we already handle whitespace above
  ;expect digits now, if non digit, stop parsing
  cmp dl, '0' 
  jb .ri_done ;not a digit
  cmp dl, '9'
  ja .ri_done ;not a digit
  ;digit -> multiply accumulator by 10 and add digit
  movzx rax, dl ;rax = digit char
  sub rax, '0' ;rax = digit value
  ;multiply rbx by 10
  mov rdx, rbx
  shl rbx, 1 ;rbx=rbx*2
  lea rbx, [rbx+rbx*4] 
  add rbx, rdx
  imul rbx, rbx, 10
  add rbx, rax ;rbx += digit
  inc r8
  jmp .ri_parse_loop

.ri_done:
  
  
