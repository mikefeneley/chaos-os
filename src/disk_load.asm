

;mov bx,HELLO_WORLD 
;call print_string
;mov bx, GOODBYE_WORLD
;call print_string

;jmp disk_load

; load DH sectors to ES:BX from drive DL
disk_load :
    push dx ; Store DX on stack so later we can recall

    call print_hex

    ; how many sectors were request to be read ,
    ; even if it is altered in the meantime
    mov ah, 0x02 ; BIOS read sector function
    mov al, dh ; Read DH sectors
    mov dh, 0x00 ; Select head 0


    mov ch, 0x00
    mov cl, 0x02 ; Start reading from second sector ( i.e.

    jmp $

;    mov dx, ax
;    call print_hex 
    
;    jmp $

    ; after the boot sector )
    int 0x13 ; BIOS interrupt
   
;   jc disk_error ; Jump if error ( i.e. carry flag set )
    
    call print_hex

    mov dx, ax
    call print_hex


    jmp $
    
    pop dx ; Restore DX from the stack
    cmp dh , al ; if AL ( sectors read ) != DH ( sectors expected )
    jne disk_error ; display error message
    ret

disk_error :
    mov bx, DISK_ERROR_MSG
    call print_string
    jmp $

; Variables
DISK_ERROR_MSG:
    db "Disk read error", 0

HELLO_WORLD:
    db "HelloWorldz", 0

GOODBYE_WORLD:
    db "Goodbye Worldz", 0
