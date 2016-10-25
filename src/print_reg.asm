

print_reg:
    push ax
    push bx
    push cx
    push dx


    mov [HOLD1], ax
    mov [HOLD2], dx

    mov ah, 0x0e
    mov al, 'A'
    int 0x10
    mov al, " "
    int 0x10
   
    mov dx, [HOLD1]
    call print_hex 

    int 0x10
    mov al, 'B'
    int 0x10
    mov al, ' '
    int 0x10
    mov dx, bx
    call print_hex 
    
    int 0x10
    mov al, 'C'
    int 0x10
    mov al, ' '
    int 0x10
    mov dx, cx
    call print_hex
    int 0x10

    mov al, 'D'
    int 0x10
    mov al, ' '
    int 0x10
    mov dx, [HOLD2]
    call print_hex
    int 0x10

    pop dx
    pop cx
    pop bx
    pop ax
    ret

print_regD:
    mov ah, 0x0e
    mov al, 'D'
    int 0x10
    mov al, ' '
    int 0x10
    call print_hex



HOLD1:
    dw 0
HOLD2:
    dw 0
