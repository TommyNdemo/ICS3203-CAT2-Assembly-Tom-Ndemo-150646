section .data
    prompt db "Enter a number for factorial: ", 0
    result db "Factorial: ", 0

section .bss
    num resb 4

section .text
    global _start

_start:
    ; Prompt user
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, 27
    int 0x80

    ; Read input
    mov eax, 3
    mov ebx, 0
    mov ecx, num
    mov edx, 4
    int 0x80

    ; Calculate factorial
    mov eax, [num]
    call factorial

    ; Print result
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 10
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80

factorial:
    push ebp
    mov ebp, esp
    push eax

    mov ecx, eax
    dec ecx
    test ecx, ecx
    jz done

loop:
    mul ecx
    dec ecx
    test ecx, ecx
    jnz loop

done:
    pop eax
    pop ebp
    ret
