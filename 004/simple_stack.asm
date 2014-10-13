mov ah, 0x0e ; Set up teletype for printing.

mov bp, 0x8000 ; Set the base pointer of the stack somewhere
               ; above where we know the BIOS drops us (0x7c00)
mov sp, bp     ; Set the stack pointer to be the same location
               ; as our base pointer initially. The stack pointer
               ; will grow downwards to lower memory addresses
               ; as items get pushed onto it.

               ; We run into trouble if we ever go past 0x7e00.
               ; The 512 bytes from 0x7e00 - 0x7c00 will be the
               ; location of this file in memory.

push 'A'       ; Push the ASCII value for each of these characters
push 'B'       ; onto the stack. The stack is LIFO, so when we pop
push 'C'       ; we expect to see C first and A last.

pop bx         ; Store the most recently pushed item into bx.
mov al, bl     ; Move the low bits of bx into al for printing.
int 0x10       ; Print.

pop bx
mov al, bl
int 0x10

mov al, [0x7ffe] ; Demonstrate the stack grows down from the base address.
                 ; Take the contents of the item at Base Pointer - 2.
                 ; All items pushed onto the stack are 16 bits.
                 ; This should be the location of the first item on the stack.
int 0x10

times 510-($-$$) db 0

dw 0xaa55
