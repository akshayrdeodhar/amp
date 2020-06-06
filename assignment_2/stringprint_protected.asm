[bits 32]

vga equ 0xb8000

white_on_black equ 0x0f

print_string_pm:
	pusha
	mov edx, vga

print_string_pm_loop:
	mov al, [ebx]
	mov ah, white_on_black
	or al, al
	jz print_string_pm_end

	mov [edx], ax

	add ebx, 1
	add edx, 2

	jmp print_string_pm_loop

print_string_pm_end:
	popa
	ret
