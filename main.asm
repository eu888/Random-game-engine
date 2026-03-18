default rel

extern GetModuleHandleA
extern ExitProcess
extern MessageBoxA
extern vkCreateInstance
extern vkEnumeratePhysicalDevices
extern vkDestroyInstance

section .data
    title: db "App", 0
    text:  db "ok", 0
    vk_init_good: db "Vulkan driver init succesefull", 0
    vk_init_bad: db "Error", 0

    gpu_count: dd 0

    align 8
    instance: dq 0
    vk_struct_type_instance_info: 
        dd 1 ;sType
        dd 0 ;padding

        dq 0 ;pNext

        dd 0 ;flags
        dd 0 ;padding

        dq 0 ;pApplicationInfo

        dd 0 ;enabledLayerCount
        dd 0 ;padding

        dq 0 ;ppEnabledLayerNames

        dd 0 ;enabledExtensionCount
        dd 0 ;padding
        
        dq 0 ;ppEnabledExtensionNames

section .bss
    gpu_handles: resq 4

section .text
    global main

    main:     
        call init_vulkan
        call cleanup

    init_vulkan:
        call createInstance
        call pickPhysicalDevice
        call no_error
        ret

    createInstance:
        sub rsp, 40
        lea rcx, [vk_struct_type_instance_info]
        xor rdx, rdx
        lea r8, [instance] 
        call vkCreateInstance
       
        test rax, rax
        jnz error
        add rsp, 40
        ret

    pickPhysicalDevice:
        sub rsp, 40
        mov rcx, [instance]
        lea rdx, [gpu_count]
        xor r8, r8
        call vkEnumeratePhysicalDevices

        test rax, rax
        jnz error

        mov rdx, [instance]
        lea rdx, [gpu_count]
        lea r8, [gpu_handles]
        call vkEnumeratePhysicalDevices
        add rsp, 40
        ret

    no_error:
        sub rsp, 40
        xor rcx, rcx          
        lea rdx, [vk_init_good]         
        lea r8,  [title]       
        mov r9,  0              
        call MessageBoxA
        add rsp, 40
        ret

    error:
        sub rsp, 40
        xor rcx, rcx          
        lea rdx, [vk_init_bad]         
        lea r8,  [title]       
        mov r9,  0              
        call MessageBoxA
        add rsp, 40
        ret

    cleanup:
        sub rsp, 40
        mov rcx, [instance]
        xor rdx, rdx
        call vkDestroyInstance
        
        xor rcx, rcx
        call ExitProcess