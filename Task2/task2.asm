section .data
    prompt db "Enter 5 integers separated by spaces: ", 0
    result db "Reversed Array: ", 0

section .bss
    array resb 20          ; Array to hold 5 integers (4 bytes each)

section .text
    global _start

_start:
    ; Prompt user
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, 33
    int 0x80

    ; Read input
    mov eax, 3
    mov ebx, 0
    mov ecx, array
    mov edx, 20
    int 0x80

    ; Reverse array (in-place)
    mov esi, array         ; Start pointer
    mov edi, array + 16    ; End pointer

reverse_loop:
    cmp esi, edi
    jge reverse_done

    ; Swap values at esi and edi
    mov eax, [esi]
    mov ebx, [edi]
    mov [esi], ebx
    mov [edi], eax

    ; Move pointers
    add esi, 4
    sub edi, 4
    jmp reverse_loop

reverse_done:
    ; Print result message
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 16
    int 0x80

    ; Print reversed array
    mov esi, array
print_loop:
    cmp esi, array + 20
    je end

    mov eax, [esi]
    ; Convert integer to ASCII here (not shown for brevity)
    ; Print converted number

    add esi, 4
    jmp print_loop

end:
    mov eax, 1
    xor ebx, ebx
    int 0x80
