; A simple boot sector that outputs 'Hello'.

; In order to interact with the screen we make use of interrupts.
; These are special routines specified by the BIOS.
; Every interrupt is identified by a number which is an index
; into a vector of 'interrupt service routines'.
; In our case 0x10 is the interrupt to print to the screen.

; Setting the high byte of ax (ah) to 0x0e indicates we want
; 'tele-type' mode. We then set the low byte of ax (al) to
; the ASCII value of the character we want to display.

mov ah, 0x0e

mov al, 'H'
int 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
mov al, 'l'
int 0x10
mov al, 'o'
int 0x10

jmp $ ; Loop forever.

times 510-($-$$) db 0 ; Pad the boot sector.

dw 0xaa55 ; Magic number.
