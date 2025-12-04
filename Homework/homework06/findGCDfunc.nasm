global gcd

section .text
;----------------------------------------
;unit64_t gcd(unit64_t a, unit64_t b)
;system v amd64 calling convention:
;  RDI = a
; RSI = b
; Return:
;  RAX = gcd(a, b)
;----------------------------------------

gcd:
.gcd_loop:
  test rsi, rsi ;if b==0, done
  je .done

  xor rdx, rdx ;clear high bits for unsigned div
  mov rax, rdi ;a
  div rsi ;rax=a/b, rdx=a%b

  mov rdi, rsi ;a=b
  mov rsi, rdx ;b=remaineder
  jmp .gcd_loop

.done:
  mov rax, rdi ;return gcd
  ret
