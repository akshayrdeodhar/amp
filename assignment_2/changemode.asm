SECTION .stack
SECTION .data

;R_MSG DB "R", 0dh, 0ah, "$"
;P_MSG DB "P", "$"

G_TABLE DW 0000h, 0000h, 0000h, 0000h,; NULL
CSD DW     01ffh, 7c00h, 9a00h, 0000h,; CSD
DSD DW	   0xffff, 7c00h, 9200h, 0000h,; DSD
ESD DW	   7fffh, 8000h, 920bh, 0000h,; ESD
SSD DW	   7c00h, 0000h, 9200h, 0000h ; SSD

SECTION .code

R_MODE:
	xor ax, ax
	mov ss, ax
	mov sp, 0x7c00
	; Initialized up-growing stack from 0000h- 7c00h

	mov ax, 0x7c00
	mov ds, ax
	; Initialized ds to start from current stack
	
	mov ax, 0xb800
	mov es, ax
	; Initialized es to point to the VGA location

;	mov si, R_MSG
;	mov di, 00h
;	call display

	mov eax, G_TABLE
	mov bx, 0027h
	sub sp, 0x0006
	mov si, sp
	mov [si], bx
	add si, 0x02
	mov [si], eax
	sub si, 0x02
	lgdt [si]     ; load gdtr from stack
	add sp, 0006h ; artificially clear stack
	
	mov eax, cr0
	or eax, 1
	mov cr0, eax  ; enter protected mode

	; PROTECTED MODE PROGRAM STARTS HERE

	mov ax, 0x0020
	mov ss, ax
	mov ax, 0x0008
	mov cs, ax ; how was code executing before this?
	mov ax, 0x0010
	mov ds, ax
	mov ax, 0x0018
	mov es, ax
;	mov si, P_MSG
;	mov di, 0xb800;
;	call display

	mov ah, 00h
	int 16h ; wait for keystroke
	hlt


;display:
	; Pushing in stack seems dangerous in protected mode
	; What will be the size of the push? 32 bits?
;	mov bp, sp
;	cld ; LODSB should move forward
;	mov ah, 0x1f
;back_display:
;	lodsb
;	cmp al, "$"
;	jnz back_display
;	stosb
;	jmp back_display
;	ret
	
times 510 - ($ - $$) db 0 ; 510 - (current byte count - starting byte count)
			  ; padded with 0s

dw 0xaa55  ; bootable sector!

