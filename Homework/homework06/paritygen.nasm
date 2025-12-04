;--------------------------------------------
; paritygen.nasm - compute odd parity for a byte
;  to assemble: nasm -f macho64 paritygen.nasm
;  to link:     gcc paritygen.o -o paritygen
;  to run:      ./paritygen
;--------------------------------------------

global _main
extern _printf
extern _scanf

section .data
    fmt_in  db "%hhu", 0        ; format string for reading unsigned byte
    fmt_out db "%c", 10, 0      ; format for printing parity + newline
    byte_val dq 0               ; store byte value

section .text
_main:
    ; stack alignment and saving registers (mirrors echoer.nasm)
    push rdi
    push rsi
    sub rsp, 8                  ; align stack for C call

    ; --- Read a single byte from stdin ---
    lea rdi, [fmt_in]           ; pointer to format string
    lea rsi, [byte_val]         ; pointer to byte_val
    xor rax, rax                ; required for variadic call
    call _scanf

    ; --- Load byte into AL and count 1 bits ---
    mov al, byte [byte_val]
    xor bl, bl                  ; bl = counter for 1 bits
.count_loop:
    test al, al
    jz .count_done
    mov cl, al
    and cl, 1
    add bl, cl
    shr al, 1
    jmp .count_loop
.count_done:

    ; --- Compute odd parity ---
    mov al, bl
    and al, 1
    xor al, 1                   ; flip for odd parity

    ; --- Print result ---
    lea rdi, [fmt_out]
    movzx rsi, al
    xor rax, rax
    call _printf

    ; restore stack and registers
    add rsp, 8
    pop rsi
    pop rdi

    xor eax, eax                ; return 0
    ret
