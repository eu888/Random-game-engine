nasm -f win64 main.asm -o main.o
gcc -m64 main.o -o main.exe -lkernel32 -luser32
gcc main.o -o app.exe -L"C:\VulkanSDK\1.4.341.1\Lib" -lvulkan-1 -luser32 -lkernel32