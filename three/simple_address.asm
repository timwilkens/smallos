[org 0x7c00] ; The base address that the BIOS will load our program to.
             ; This instruction relativizes all of our labels.

mov ah, 0x0e ; Set up teletype mode.

mov al, [our_mark] ; Take the contents at the address pointed to by label 
                   ; and move them into al. In our case, this is the ASCII
                   ; code for "X".

                   ; If we hadn't relativized with [org 0x7c00] we could
                   ; done the following:
                   ; mov bx, our_mark
                   ; add bx, 0x7c00
                   ; mov al, [bx]

int 0x10 ; Interrupt. Print to screen.

jmp $ ; Loop forever.

our_mark: ; Use this label to point a RELATIVE memory address containin the 
  db "X"  ; ASCII code for "X".

times 510-($-$$) db 0 ; Pad out.

dw 0xaa55 ; Magic number.
