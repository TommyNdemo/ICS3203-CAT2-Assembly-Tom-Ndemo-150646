section .data
    prompt db "Enter a number: ", 0
    positive db "POSITIVE", 0
    negative db "NEGATIVE", 0
    zero db "ZERO", 0

section .bss
    num resb 4

section .text
    global _start

_start:
    ; Print prompt
    mov eax, 4            ; syscall for write
    mov ebx, 1            ; file descriptor for stdout
    mov ecx, prompt       ; message address
    mov edx, 15           ; message length
    int 0x80

    ; Read number input
    mov eax, 3            ; syscall for read
    mov ebx, 0            ; file descriptor for stdin
    mov ecx, num          ; buffer to store input
    mov edx, 4            ; max input length
    int 0x80

    ; Convert ASCII input to integer
    sub byte [num], '0'

    ; Branching logic
    mov al, [num]
    cmp al, 0
    je is_zero
    jl is_negative
    jmp is_positive

is_positive:
    mov eax, 4
    mov ebx, 1
    mov ecx, positive
    mov edx, 8
    int 0x80
    jmp end

is_negative:
    mov eax, 4
    mov ebx, 1
    mov ecx, negative
    mov edx, 8
    int 0x80
    jmp end

is_zero:
    mov eax, 4
    mov ebx, 1
    mov ecx, zero
    mov edx, 4
    int 0x80

end:
    ; Exit program
    mov eax, 1
    xor ebx, ebx
    int 0x80
