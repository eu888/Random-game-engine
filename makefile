nasm -f win64 main.asm -o main.o
gcc -m64 main.o -o main.exe -lkernel32 -luser32