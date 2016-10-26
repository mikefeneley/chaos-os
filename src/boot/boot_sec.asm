[org 0x7c00] 
KERNEL_OFFSET equ 0x1000

    mov [BOOT_DRIVE], dl

    mov bp, 0x9000

    mov sp, bp
   
    mov bx, MSG_REAL_MODE
    call print_string
  
    call load_kernel
    
    call switch_to_pm ; Note that we never return from here.
    jmp $



;%include "test.asm"
;%include "print_reg.asm"
;%include "print_hex.asm"
%include "print_string.asm" ; Re - use our print_string function
%include "disk_load.asm"
%include "print.asm"
%include "gdt.asm"
%include "switch.asm"

[bits 16]

load_kernel :
    mov bx, MSG_LOAD_KERNEL ; Print a message to say we are loading the kernel
    call print_string
    mov bx, KERNEL_OFFSET ; Set -up parameters for our disk_load routine , so
    mov dh, 15 ; that we load the first 15 sectors ( excluding
    mov dl, [BOOT_DRIVE] ; the boot sector ) from the boot disk ( i.e. our
    call disk_load ; kernel code ) to address KERNEL_OFFSET
    ret

[bits 32]

BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm ; Use our 32 - bit print routine.
   
    call KERNEL_OFFSET
    jmp $ ; Hang.


BOOT_DRIVE db 0
MSG_REAL_MODE db " Started in 16 - bit Real Mode " , 0
MSG_PROT_MODE db " Successfully landed in 32 - bit Protected Mode " , 0
MSG_LOAD_KERNEL db " Loading kernel into memory. " , 0



; Bootsector padding
times 510-($-$$) db 0
dw 0xaa55
