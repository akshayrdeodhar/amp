realmode.bin: realmode.asm
	nasm -f bin realmode.asm -o realmode.bin

test: realmode.bin
	qemu-system-x86_64 -fda realmode.bin

clean: 
	rm *.bin *~
