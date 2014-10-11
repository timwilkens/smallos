[org 0x7c00]

  mov [BOOT_DRIVE], dl ; BIOS stores the location of our boot drive in dl.
                       ; Save for later.

  mov bp, 0x8000 ; Set up the stack.
  mov sp, bp

  mov bx, 0x9000       ; This is the start address we want data loaded to.
  mov dh, 2            ; Read 2 sectors
                       ; NOTE: the tutorial has this listed as 5. At least
                       ; on my system this gives a disk error, probably
                       ; because there are only two additional sectors.
                       ; Changing to 2 to match the two declared below seems
                       ; to fix the issue.

  mov dl, [BOOT_DRIVE] ; Set boot drive location.
  call disk_load       ; Load it.

  mov dx, [0x9000] ; Load the first word in our loaded memory into dx.
  call print_hex   ; Should print 0xDADA

  mov dx, [0x9000 + 512] ; Load the first word from our section section.
  call print_hex         ; Should print 0xFACE

  jmp $ ; Loop

BOOT_DRIVE: db 0

%include "../print_hex.asm"
%include "../read_disk.asm"

%include "../end_boilerplate.asm"

times 256 dw 0xdada ; Extra data to be loaded from disk.
                    ; Two 512 byte sections.
times 256 dw 0xface
