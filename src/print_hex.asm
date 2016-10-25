print_hex:
    push ax
    push bx
    push dx
    mov ah, 0x0e   
    jmp FIRST

FIRST:
    mov bx, dx
    and bx, 0x000F 
    cmp bx, 10
    jge LETTER1   
    add bx, '0' 
    mov [HEX_OUT + 5], bl
    jmp SECOND

LETTER1:
    add bx, 55
    mov [HEX_OUT + 5], bl
    jmp SECOND

SECOND:

    mov bx, dx
    and bx, 0x00F0
    shr bx, 4 
    cmp bx, 10
    jge LETTER2
    add bx, '0'
    mov [HEX_OUT + 4], bl
    jmp THIRD

LETTER2:
    add bx, 55
    mov [HEX_OUT + 4], bl
    jmp THIRD


THIRD:
    mov bx, dx
    and bx, 0x0F00
    shr bx, 8 
    cmp bx, 10
    jge LETTER3
    add bx, '0'
    mov [HEX_OUT + 3], bl
    jmp FOURTH

LETTER3:
    add bx, 55
    mov [HEX_OUT + 3], bl
    jmp FOURTH

FOURTH:
    mov bx, dx
    and bx, 0xF000
    shr bx, 12 
       
    cmp bx, 10
    jge LETTER4
    add bx, '0'
    mov [HEX_OUT + 2], bl
    jmp END

LETTER4:
    add bx, 55
    mov [HEX_OUT + 2], bl
    jmp END 

END:
    mov dl, 'x'
    mov [HEX_OUT + 1], dl    
    mov dl, '0'
    mov [HEX_OUT], dl

    mov bx, HEX_OUT

    call print_string

    pop dx
    pop bx
    pop ax
    ret


HEX_OUT: 
    db '0x0000', 0


