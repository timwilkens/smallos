mov al, 'T' ; Set up our single argument to print.
call print  ; Call our print function.
            ; 'call' effectively pushes the address
            ; of the next instruction onto the stack
            ; and then jumps to the address for 'print'.

jmp $ ; Loop.

%include "print_char.asm" ; Simple include.
                          ; Replaces this text with the contents
                          ; of that file.

times 510-($-$$) db 0 ; Pad.
dw 0xaa55 ; Magic number.

; Note: the padding and magic word declaration must be the
; last items in the file. Other wise we will pad the sector
; correctly and end up ignoring anything after byte 512.
; E.g. putting the include at the end will cause it to 
; be ignored.
