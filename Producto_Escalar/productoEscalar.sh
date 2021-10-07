nasm -f elf32 escalar.asm -o escalar.o;
gcc -m32 escalar.o -o productoEscalar;
./productoEscalar;

