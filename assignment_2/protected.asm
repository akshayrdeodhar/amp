org 0x7c00
;[bits 16]

real_mode:
	mov bp, 0xf000
	mov sp, bp

	mov al, 0x03  ; 80 rows, 25 columns
	mov ah, 0x00   ; set video mode 
	int 0x10      ; BIOS Video RAM calls

	mov ah, 0x02
	mov dh, 13
	mov dl, 0
	int 0x10

	mov si, real_mode_message
	push si
	call stringprint 
	pop si

	cli
	lgdt [gdt_descriptor]
	mov eax, cr0
	or eax, 1
	mov cr0, eax  ; enter protected mode

	jmp cs_selector:protected_mode

real_mode_again:

	mov ah, 2
	mov dh, 14
	mov dl, 0
	int 0x10
	
	mov si, back_msg 
	push si
	call stringprint 
	pop si

	mov ah, 0x00
	int 16h ; wait for keystroke
	hlt

%include "stringprint.asm"
%include "gdt.asm"
%include "stringprint_protected.asm"

[bits 32]
protected_mode:

	mov ax, ds_selector
	mov ss, ax
	mov ds, ax
	mov es, ax

	mov ebp, 0x9000
	mov esp, ebp

	mov ebx, return_message 
	call print_string_pm
	
	cli

	mov eax, cr0
	and eax, 0xfffe
	mov cr0, eax

	;jmp 0x7c00:real_mode_again

	jmp $

real_mode_message db "Before protected mode"
db 0x00
return_message db "In protected mode"
db 0x00
back_msg db "Real mode again"
db 0x00

times 510 - ($ - $$) db 0 ; 510 - (current byte count - starting byte count)
	
dw 0xaa55 ; magic cookie