print_string:
    push bx
    mov ah, 0x0e
loop:
    mov al, [bx]
    int 0x10
    inc bx    
    cmp al, 0    
    jne loop
    ret
