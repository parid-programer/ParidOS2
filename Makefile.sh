rm ParidOS2.bin
rm ParidOS2.iso
/home/parid/opt/cross/bin/i686-elf-as boot.s -o boot.o
/home/parid/opt/cross/bin/i686-elf-gcc -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
/home/parid/opt/cross/bin/i686-elf-gcc -T linker.ld -o ParidOS2.bin -ffreestanding -O2 -nostdlib boot.o kernel.o
if grub-file --is-x86-multiboot ParidOS2.bin; then
  echo multiboot confirmed
else
  exit
fi
mkdir -p isodir/boot/grub
cp ParidOS2.bin isodir/boot/ParidOS2.bin
cp grub.cfg isodir/boot/grub/grub.cfg
grub-mkrescue -o ParidOS2.iso isodir
rm -rf isodir
rm kernel.o
rm boot.o
