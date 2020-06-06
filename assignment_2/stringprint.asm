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

	;mov ah, 02h
	;mov dh, 13
	;mov dl, 30
	; set cursor to approximate center of screen
	;int 10h

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


