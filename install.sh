#!/bin/sh

rm -f *.jos
echo -e "__JOS\n"
echo -e "--------------------------------"
echo -e "-          assembling          -"
echo -e "--------------------------------"
nasm -f bin -o boot.jos boot.asm
nasm -f elf -o jos32.jos jos32.asm
nasm -f elf -o jos32struc.jos jos32struc.asm
nasm -f elf -o ccpu.jos ccpu.asm
nasm -f elf -o idt.jos idt.asm
nasm -f elf -o int38.jos int38.asm
nasm -f elf -o keyboard.jos keyboard.asm
echo -e "\n"
echo -e "--------------------------------"
echo -e "-            linking           -"
echo -e "--------------------------------"
ld jos32.jos jos32struc.jos ccpu.jos idt.jos int38.jos keyboard.jos -o kernel.jos --oformat binary -Ttext 0x0 -e _start32
echo -e "\n"
echo -e "--------------------------------"
echo -e "-            writing           -"
echo -e "--------------------------------"
dd if=./boot.jos of=/dev/fd0 bs=512 count=1
sleep 1
dd if=./kernel.jos of=/dev/fd0 bs=512 count=36 seek=1
echo -e "\n"
echo -e "DONE\a\n"
