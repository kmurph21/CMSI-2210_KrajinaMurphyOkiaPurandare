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
  cmp dl, 0x0A ;newline
  je .ri_done
  cmp dl, 0x0D ;carriage return
  je .ri_done
  cmp dl, ' ' ;space
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
  imul rbx, rbx, 10
  add rbx, rax ;rbx += digit
  inc r8
  jmp .ri_parse_loop

.ri_done:
  mov rax, rbx ;return value in rax
  ret

.ri_return_zero:
  xor rax, rax
  ret

;--------------------------------------------
;gcd
;Inputs: RDI=a, RSI=b, Returns: RAX=gcd(a, b)
;Uses Euclidean algorithm with 64 bit unsigned division
;--------------------------------------------
gcd:
  ;handle if b==0: gcd(a, 0) = a

.gcd_loop:  
  test rsi, rsi
  je .gcd_done
  xor rdx, rdx ;clear RDX before div
  mov rax, rdi
  div rsi ;rax=rdi/rsi, rdx=rdi%rsi
  mov rdi, rsi ;a=b
  mov rsi, rdx ;b=remainder
  jmp .gcd_loop

.gcd_done:
  mov rax, rdi ;result in rax
  ret

;--------------------------------------------
;print_unit
;prints unsigned 64 bit integer value in RAX followed by newline
;clobbers: RBX, RDX, RCX, RDI, RSI, RAX
;--------------------------------------------
print_unit:
  ;if value is zero, print "0\n"
  test rax, rax
  jne .print_convert
  lea rsi, [rel buffer+62]
  mov byte [rsi], '0'
  mov byte [rsi+1], 0x0A
  ;write(1, rsi, 2)
  mov rax, 1
  mov rdi, 1
  mov rdx, 2
  syscall
  ret

.print_convert:
  lea rdi, [rel buffer+63] ;write backwards from buffer+63
  mov byte [rdi], 0x0A ;newline at last byte
  dec rdi
  mov rbx, 10

.print_loop:
  xor rdx, rdx
  div rbx ;divide RDX: RAX by 10 -> quotient in RAX, remainder in RDX
  add dl, '0'
  mov [rdi], dl
  dec rdi
  test rax, rax
  jne .print_loop
  inc rdi ;rdi now points to first digit
  ;compute length=(buffer+64)-rdi
  lea rcx, [rel buffer+64]
  mov rdx, rcx
  sub rdx, rdi ;rdx=length
  ;write(1, rdi, rdx)
  mov rax, 1
  mov rsi, rdi
  mov rdi, 1
  syscall
  ret

;--------------------------------------------
;_start - main program
;--------------------------------------------
_start:
  ;read first integer, RAX
  call read_integer
  mov [a], rax
  ;read second integer, RAX
  call read_integer
  mov [b], rax
  ;compute gcd([a], [b])
  mov rdi, [a]
  mov rsi, [b] 
  call gcd ;result in RAX
  ;print result
  call print_unit
  ;exit(0)
  mov rax, 60 ;sys exit
  xor rdi, rdi
  syscall

;--------------------------------------------
;nasm -f elf64 findGCD.nasm -o findGCD.o
;ld findGCD.o -o findGCD
; to run do: ./findGCD then type 3113041662 and 11570925 and output should be 462837
;--------------------------------------------
