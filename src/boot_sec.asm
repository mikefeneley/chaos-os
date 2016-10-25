

[org 0x7c00] 

    mov bp, 0x9000

    mov sp, bp
   
    mov bx, MSG_REAL_MODE
    call print_string
   
    call switch_to_pm ; Note that we never return from here.
    jmp $



%include "test.asm"
;%include "print_reg.asm"
%include "print_hex.asm"
%include "print_string.asm" ; Re - use our print_string function
%include "disk_load.asm"
%include "print.asm"
%include "gdt.asm"
%include "switch.asm"

BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm ; Use our 32 - bit print routine.
    jmp $ ; Hang.


MSG_REAL_MODE db "Started in 16 bit real mode", 0
MSG_PROT_MODE: 
    db "Switched to 32 bit mode", 0

; Bootsector padding
times 510-($-$$) db 0
dw 0xaa55
