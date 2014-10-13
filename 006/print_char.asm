print:
  pusha        ; Store all current register values on the stack.
               ; This way the caller can assume all registers
               ; will have the same values on return.

  mov ah, 0x0e 
  int 0x10     ; Do the printing.
  popa         ; Restore all registers.
  ret          ; Pop the return address of the calling
               ; function from the stack and jump to it.
