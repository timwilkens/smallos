; Padding and magic number that comes at the end
; of all boot sectors.

times 510-($-$$) db 0
dw 0xaa55
