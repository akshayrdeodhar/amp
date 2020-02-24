changemode.bin: changemode.asm
	nasm -f bin changemode.asm -o changemode.bin

test: changemode.bin
	qemu-system-x86_64 -fda changemode.bin

clean: 
	rm *.bin *~
