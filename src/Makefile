# Automatically generate lists of sources using wildcards
C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)

# TODO: Make sources dep on all headers


# Convers the #.c filenames to *.o to give a list of object files to be built
OBJ = ${C_SOURCES:.c=.o}




all: os-image

run: all
	qemu-system-i386 os-image

os-image: boot/boot_sec.bin kernel.bin
	cat $^ > os-image

kernel.bin: kernel/kernel_entry.o ${OBJ}
	ld -o $@ -m elf_i386 -Ttext 0x1000 $^ --oformat binary

%.o : %.c ${HEADERS}
	gcc -ffreestanding -c -m32 -elf $< -o $@

%.o : %.asm
	nasm $< -f elf -o $@

%.bin : %.asm
	nasm $< -I "./boot/" -o $@ 

clean:
	rm -fr *. bin *. dis *. o os-image
	rm -fr kernel/*.o boot/*.bin drivers/*.o
