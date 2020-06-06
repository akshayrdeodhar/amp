global mmxtranspose
global endmmx

section .data
section .text

endmmx:
	emms
	ret

mmxtranspose:
	movq mm0, [rdi]
	movq mm1, [rdi + 8]
	punpcklbw mm0, mm1
	movq mm2, [rdi + 16]
	movq mm3, [rdi + 24]
	punpcklbw mm2, mm3 
	movq mm5, mm0 
	punpcklwd mm0, mm2
	punpckhwd mm5, mm2
	movq mm4, mm0
	movq mm0, [rdi]
	movq mm1, [rdi + 8]
	punpckhbw mm0, mm1
	movq mm2, [rdi + 16]
	movq mm3, [rdi + 24]
	punpckhbw mm2, mm3
	movq mm7, mm0
	punpcklwd mm0, mm2
	punpckhwd mm7, mm2
	movq mm6, mm0
	;movq mm4, [rdi]
	;movq mm5, [rdi + 8]
	;movq mm6, [rdi + 16]
	;movq mm7, [rdi + 24]
	movq [rsi], mm4
	movq [rsi + 8], mm5
	movq [rsi + 16], mm6
	movq [rsi + 24], mm7
	ret
