kernel.bin: bootloader.bin prog.bin
	cat bootloader.bin prog.bin >| kernel.bin

bootloader.bin: bootloader.asm
	nasm -fbin bootloader.asm -o bootloader.bin

prog.bin: prog.asm
	nasm -fbin prog.asm -o prog.bin

oldtest: kernel.bin
	qemu-system-i386 -fda kernel.bin

test: protected.bin
	qemu-system-i386 -fda protected.bin

protected.bin: protected.asm gdt.asm stringprint.asm stringprint_protected.asm
	nasm -fbin protected.asm -o protected.bin

clean: 
	rm *.bin *~
