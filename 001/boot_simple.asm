; A super simple boot sector written in assembly.

; Assemble to turn into machine code:
; nasm boot_simple.asm -f bin -o boot_simple.bin

; Run with QEmu
; qemu-system-x86_64 boo_simple.bin

; Result: should loop forever

loop:
    jmp loop ; Loop forever. This is the 'main' of our
             ; small operating system.

times 510-($-$$) db 0 ; Pad our data out from the current
                      ; location to 510 bytes. A boot
                      ; sector is expected to be 512 bytes.

dw 0xaa55 ; Add on the 'magic number'.
          ; This two byte sequence is how the BIOS
          ; recognizes a device as having a valid
          ; boot sector.

; All operating systems use a boot sector of this style
; in order to 'bootstrap' into a higher language.
