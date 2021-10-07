nasm -f elf32 resolvente.asm -o resolvente.o;
gcc -m32 -o resolvente resolvente.o formulaResolvente.c;
./resolvente;

