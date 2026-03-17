default rel

extern GetModuleHandleA
extern ExitProcess
extern MessageBoxA

section .data
    title db "Hello", 0
    text  db "Hello from x64 Assembly!", 0

section .text
global main

main:
    sub rsp, 40             

    xor rcx, rcx          
    lea rdx, [text]         
    lea r8,  [title]       
    mov r9,  0              

    call MessageBoxA

    xor rcx, rcx
    call ExitProcess
