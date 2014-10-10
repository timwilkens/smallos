[org 0x7c00] ; Make all addresses relative to where
             ; the BIOS drops us.

mov bx, Hello     ; Use bx as our argument register.
call print_string ; Function call.

mov bx, Goodbye
call print_string

jmp $

; Single argument value passed in register ax.
print_char:
  pusha        ; Store all regs.
  mov ah, 0x0e 
  int 0x10     ; Print.
  popa         ; Restore.
  ret

; Single argument passed as a memory address stored
; in bx.
print_string:
  pusha ; Save registers.

  mov cx, [bx] ; Store the value saved at the memory
               ; address stored in bx in cx.

loop:
  cmp cl, 0 ; Compare the low byte of cl to 0.
  je end    ; If it is zero, we have reached
            ; the end of our null terminated string.
            ; Jump to the end of this function.

  mov al, cl      ; Set up argument to print_char.
  call print_char ; Call.

  add bx, 1    ; Add one to the memory address stored in bx.
  mov cx, [bx] ; Move the next char in the string into cx.
  jmp loop     ; Repeat.

end:
  popa ; Restore registers.
  ret  ; Return.

Hello:
  db 'Hello, World.', 0 ; Null terminated string.

Goodbye:
  db 'Bye Bye', 0

times 510-($-$$) db 0
dw 0xaa55
