[org 0x7c00] ; Change base of all addresses.

mov dx, 0x1fd8 ; Set up argument.
call print_hex ; Call.

jmp $

; Expect argument in ax. Destructively edit in place.
normalize: ; Shift values to their ascii representation value.

  cmp ax, 9  ; See if this is a number.
  jle number ; Jump.

  add ax, 55 ; This must be a letter.
             ; To go from hex representation (10 - 16)
             ; to ASCII code we add 55
  ret

number:
  add ax, 48 ; Add 48 to (0 - 9) to get ASCII version
             ; of each number.
  ret

; Expect argument value in dx
print_hex:
  pusha ; Store regs.

  mov ax, dx ; Move the value to print into ax
  shr ax, 12 ; Shift right 12 to get highest four bits,
             ; which is the leftmost hex character.
  call normalize ; Normalize to get the ASCII code.
  mov [HEX_OUT + 2], ax ; Set the first byte of our output.
                        ; Add 2 to go past the '0x'.

  mov ax, dx
  shr ax, 8  ; As above.
  and ax, 0xf ; Mask so we only get the 4 bits we care about.
  call normalize
  mov [HEX_OUT + 3], ax ; Set.

  mov ax, dx
  shr ax, 4
  and ax, 0xf
  call normalize
  mov [HEX_OUT + 4], ax

  mov ax, dx
  and ax, 0xf ; Mask off. No need to shift since we are getting
              ; the lowest four bits.
  call normalize
  mov [HEX_OUT + 5], ax

  mov bx, HEX_OUT   ; Set up argument.
  call print_string ; Call print.

  popa
  ret

; Placeholder bytes that will get filled in by print_hex
HEX_OUT: db '0x0000', 0

%include "../print_string.asm"
%include "../end_boilerplate.asm"
