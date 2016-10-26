TEST:
    push ax 

    mov ah, 0x0e
    mov al, 'T'
    int 0x10
    mov al, 'E'
    int 0x10
    mov al, 'S'
    int 0x10
    mov al, 'T'
    int 0x10
    pop ax
    ret

