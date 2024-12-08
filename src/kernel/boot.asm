org 0x7C00
bits 16

%define ENDL 0x0D, 0x0A

start:
    jmp main


; prints a string to the screen.
; params:
;   ds:si points to string
puts:
    ; save registers
    push si
    push ax

.loop:
    lodsb           ; loads next character in al
    or al, al       ; verify if next character is null
    jz .done

    mov ah, 0x0E    ; calls bios interrupt
    mov bh, 0
    int 0x10

    jmp .loop

.done:
    pop ax
    pop si
    ret

main:

    ; setup data segments
    mov ax, 0
    mov ds, ax
    mov es, ax
    
    ; setup stack
    mov ss, ax      ; setting stack to zero
    mov sp, 0x7C00  ; stack grows downward
    
    ; print message
    mov si, msg_carlyxOS
    call puts

    hlt

.halt:
    jmp .halt


msg_carlyxOS:  db '--- Carlyx OS ---', ENDL, 0

times 510 - ($ - $$) db 0
dw 0AA55h
