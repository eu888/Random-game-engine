default rel

extern GetModuleHandleA
extern ExitProcess
extern MessageBoxA
extern vkCreateInstance
extern vkDestroyInstance

section .data
    title: db "App", 0
    text:  db "ok", 0

    instance: dq 0
    align 8
    vk_struct_type_instance_info: 
        dd 1
        align 8
        dq 0
        dd 0
        dq 0 
        dd 0
        align 8
        dq 0
        dd 0
        align 8
        dq 0

section .text
global main

main:
    sub rsp, 40 

    lea rcx, [vk_struct_type_instance_info]
    xor rdx, rdx
    lea r8, [instance] 

    call vkCreateInstance           

    xor rcx, rcx          
    lea rdx, [text]         
    lea r8,  [title]       
    mov r9,  0              

    call MessageBoxA

    lea rcx, [instance]
    xor rdx, rdx

    call vkDestroyInstance

    xor rcx, rcx
    call ExitProcess
