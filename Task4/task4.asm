section .data
    sensor db 10   ; Simulated water level sensor
    motor db 0
    alarm db 0

section .text
    global _start

_start:
    ; Read sensor value
    mov al, [sensor]
    cmp al, 15
    jg high_water
    cmp al, 5
    jge moderate_water
    jmp low_water

high_water:
    mov byte [motor], 0   ; Stop motor
    mov byte [alarm], 1   ; Trigger alarm
    jmp end

moderate_water:
    mov byte [motor], 1   ; Start motor
    mov byte [alarm], 0
    jmp end

low_water:
    mov byte [motor], 0   ; Stop motor
    mov byte [alarm], 0

end:
    ; Exit program
    mov eax, 1
    xor ebx, ebx
    int 0x80
