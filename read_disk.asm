; In order to read from disk we need to know a little bit
; about how disks are laid out. They use 
; Cylinder-Head-Sector addressing to specify which disk,
; side of disk, section, and distance from center to read.

; dl - drive to read
; ch - cylinder to read (distance from outside edge)
; dh - track (0 based)
; cl - sector (1 based)
; al - sectors to read

; [es:bx] is the start address we will read the data to.
; So, bx should be passed with the correct memory address.

disk_load:
  push dx ; Save the value in dx since we plan on using it later.
          ; This is the number of sectors to read.

  mov ah, 0x02 ; Do set up for BIOS to read from disk.
  mov al, dh   ; Read the number of sectors specified in dh.
  mov ch, 0x00 ; Select cylinder 0
  mov dh, 0x00 ; Select head 0
  mov cl, 0x02 ; Start reading in the second sector (the one
               ; after the boot sector.

  int 0x13 ; BIOS interrupt to read from disk

  jc disk_error ; If we experienced a disk error the
                ; carry register will get set.
                ; Jump to disk_error if we had an error.

  pop dx            ; Restore dx to be the number of sectors
                    ; we expected to read.
  cmp dh, al        ; al stores the number of sectors actually read.
  jne read_mismatch ; Jump to error handling if there is a mismatch.
  ret

disk_error: ; Show error message and loop forever. Don't return to caller.
  mov bx, DISK_ERROR_MESSAGE
  call print_string
  jmp $

read_mismatch: ; Show error and loop.
  mov bx, READ_ERROR_MESSAGE
  call print_string
  jmp $

; Note: we expect print_string to be included elsewhere.
; If we include it twice we get re-declaration errors.
; I'm not sure what the best strategy is.

DISK_ERROR_MESSAGE: db 'Disk read error!', 0
READ_ERROR_MESSAGE: db 'Sectors requested and read do not match!', 0
