bits 16

;org 0x7c00 ; tell NASM to start outputting stuff at offset 0x7c00org 0x7c00 ; tell NASM to start outputting stuff at offset 0x7c00

boot: 
	;mov ax, 1636 ; 1K stack space + 512 bytes for booting
	;mov ss, ax   ; stack starts 1K bytes below end of 512 bytes
	;mov sp, 1024 ; stack of 1024 bytes
	; why does this not work?

	mov ax, 0x7c0 ; data segment starts here
	mov ds, ax   ; remember, we are in real mode

videomode:
	
	mov al, 03h  ; 80 rows, 25 columns
	mov ah, 0h   ; set video mode 
	int 10h      ; BIOS Video RAM calls

	mov si, message_string
	push si
	call stringprint
	pop si

inf:
	nop
	jmp inf

	cli
	hlt

stringprint:
	mov bp, sp
	mov si, [bp + 2] ; skip the CS:SI pushed in stack
	cld

	mov bh, 00h ; page 0
	mov ah, 03h ; get curso position
	int 10h     ; dl contains cursor column

	; mov al, 01h ; set page 1 as the active page
	; mov ah, 05h
	; int 10h

	mov ah, 02h
	mov dh, 13
	mov dl, 30
	; set cursor to approximate center of screen
	int 10h

stringprint_loop_start:
	inc dl
	mov ah, 02h ; set cursor position
	int 10h

	lodsb
	or al, al
	jz stringprint_end

	mov ah, 09h	; character output
	mov cx, 0001h	; print only once
	mov bh, 00h 	; write to page 0
	mov bl, 90h	; write character to screen with attribute
	int 10h

	jmp stringprint_loop_start

stringprint_end:
	ret

message_string db "What do you get when you multiply 9 by 6"
db 0

times 510 - ($ - $$) db 0 ; 510 - (current byte count - starting byte count)
			  ; padded with 0s

dw 0xaa55  ; bootable sector!
	
