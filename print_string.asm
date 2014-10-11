; Single argument passed as a memory address stored in bx.
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

print_char:
  pusha        ; Store all current register values on the stack.
               ; This way the caller can assume all registers
               ; will have the same values on return.

  mov ah, 0x0e 
  int 0x10     ; Do the printing.
  popa         ; Restore all registers.
  ret          ; Pop the return address of the calling
               ; function from the stack and jump to it.
