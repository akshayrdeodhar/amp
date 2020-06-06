gdt_start:

gdt_null:
	dd 0x0 ; 0 doubleword
	dd 0x0 ; 0 doubleword

gdt_code:
	dw 0xffff 	; limit 
	dw 0x0000 	; base 0-15
	db 0x00   	; base 16-23
	db 10011010b    ; ARB
	db 0xf0   	; limit, bits
	db 0x00   	; base 24-31

gdt_data:
	dw 0xffff ; limit 
	dw 0x0000 ; base
	db 0x00   ; base
	db 10010010b   ; arb
	db 0xf0   ; limit, bits
	db 0x00   ; base

gdt_end:

gdt_descriptor:
	dw gdt_end - gdt_start - 1
	dd gdt_start

cs_selector equ gdt_code - gdt_start ; 0x08
ds_selector equ gdt_data - gdt_start ; 0x10
	
