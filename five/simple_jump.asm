mov bx, 30 ; Load our test value into bx.

cmp bx, 4  ; Compare bx to 4.
jle load_A ; If less than or equal to 4 we jump to
           ; instruction located at load_A.

cmp bx, 40 ; Compare bx to 40.
jl load_B  ; Jump to load_B if less than 40.

mov al, 'C' ; Unconditonally load 'C' into al.
            ; Value in bx is greater than or equal
            ; to 40.

jmp show    ; Jump to the label show to print to screen.

load_A:
  mov al, 'A' ; Load A for printing.
  jmp show

load_B:
  mov al, 'B'
  jmp show

show:
  mov ah, 0x0e ; Set up teletype.
  int 0x10     ; Print.

jmp $  ; Loop forever.

times 510-($-$$) db 0 ; Pad.

dw 0xaa55 ; Magic number so BIOS recognizes as a boot sector.
