; This file demonstrates how memory is segmented,
; and referenced relative to four different registers
; (cs, ss, ds, es) which each store a different base address.

; To get a 'real' address the CPU multiples the value
; in the segment register by 16 and adds the offset.
; Accessing memory address 0x20 ([0x20]) results
; in [segment_reg * 16 + 0x20].

; Note: in hexadecimal multiplying by 16 is just a 
; left shift. 0x7c0 * 16 = 0x7c00

; The 'org' directive essentially sets up these
; segment registers ([org 0x7c00]).

mov ah, 0x0e ; set up teletype mode

mov al , [the_secret] ; This will fail to print what we want.
                      ; The offset is not calculated from the 
                      ; correct memory segment.
int 0x10

mov bx, 0x7c0         ; This will correctly print the_secret.
                      ; We can't set ds (the data segment register)
                      ; directly so we load up bx.
mov ds, bx            ; Set ds. This value will get multiplied by 16
                      ; resulting in 0x7c00 which is the value we
                      ; normally use in the ord directive.
mov al, [the_secret]
int 0x10

mov al, [es:the_secret] ; This tells the CPU to use es as the segment
                        ; register, not ds. This will fail to print the
                        ; correct value since es doesn't contain
                        ; the right base address.
int 0x10

mov bx, 0x7c0           ; This will succeed. Set es to have the right
                        ; base and the explicitly use it to move into
                        ; al.
mov es, bx
mov al, [es:the_secret]
int 0x10

jmp $

the_secret:
 db 'X'

%include "../end_boilerplate.asm"
