
%include "hello_world.asm"
  mov ah, 0x0e
  mov al, "H"
int 0x10
mov al, "e"
int 0x10
mov al, "l"
int 0x10
mov al, "l"
int 0x10
mov al, "o"
int 0x10

call _hello


jmp $ ; Jump to the current address ( i.e. forever ).
;
; Padding and magic BIOS number.
;
times 510-($-$$) db 0 ; Pad the boot sector out with zeros
dw 0xaa55 ; Last two bytes form the magic number ,
; so BIOS knows we are a boot sector.


