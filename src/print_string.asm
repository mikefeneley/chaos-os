print_string:
    push ax
    push bx
    mov ah, 0x0e
    jmp loop
loop:
    mov al, [bx]
    int 0x10
    inc bx   
    mov al, [bx] 
    cmp al, 0    
    jne loop
    pop bx
    pop ax
    ret
