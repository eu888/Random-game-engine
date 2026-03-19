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

    DeviceProperties:
        dd 0 ;apiVersion
        dd 0 ;padding
        dd 0 ;driverVersion
        dd 0 ;padding
        dd 0 ;vendorID
        dd 0 ;padding
        dd 0 ;deviceID
        dd 0 ;padding
        dd 0 ;deviceType
        dd 0 ;padding
        times 256 db 0 ;deviceName  
        times 16 db 0 ;pipelineCacheUUID
        times 226 dd 0 ;props
        times 5 dd 0 ;sparseProperties
        dd 0 ;padding

    props:
        dd 0  ;apiVersion
        dd 0 ;padding
        dd 0  ;driverVersion
        dd 0 ;padding
        dd 0  ;vendorID
        dd 0 ;padding
        dd 0  ;deviceID
        dd 0 ;padding
        dd 0  ;deviceType
        dd 0 ;padding
        times 256 db 0 ;deviceName[256]
        times 16 db 0 ;pipelineCacheUUID[16]
        dd 0  ;maxImageDimension1D
        dd 0 ;padding
        dd 0  ;maxImageDimension2D
        dd 0 ;padding
        dd 0  ;maxImageDimension3D
        dd 0 ;padding
        dd 0  ;maxImageDimensionCube
        dd 0 ;padding
        dd 0  ;maxImageArrayLayers
        dd 0 ;padding
        dd 0  ;maxTexelBufferElements
        dd 0 ;padding
        dd 0  ;maxUniformBufferRange
        dd 0 ;padding
        dd 0   ;maxStorageBufferRange
        dd 0 ;padding
        dd 0  ;maxPushConstantsSize
        dd 0 ;padding
        dd 0  ;maxMemoryAllocationCount
        dd 0 ;padding
        dd 0  ;maxSamplerAllocationCount
        dd 0 ;padding
        dq 0  ;bufferImageGranularity (VkDeviceSize)
        dq 0  ;sparseAddressSpaceSize (VkDeviceSize)
        dd 0  ;maxBoundDescriptorSets
        dd 0 ;padding
        dd 0  ;maxPerStageDescriptorSamplers
        dd 0 ;padding
        dd 0  ;maxPerStageDescriptorUniformBuffers
        dd 0 ;padding
        dd 0  ;maxPerStageDescriptorStorageBuffers
        dd 0 ;padding
        dd 0  ;maxPerStageDescriptorSampledImages
        dd 0 ;padding
        dd 0  ;maxPerStageDescriptorStorageImages
        dd 0 ;padding
        dd 0  ;maxPerStageDescriptorInputAttachments
        dd 0 ;padding
        dd 0  ;maxPerStageResources
        dd 0 ;padding
        dd 0  ;maxDescriptorSetSamplers
        dd 0 ;padding
        dd 0  ;maxDescriptorSetUniformBuffers
        dd 0 ;padding
        dd 0  ;maxDescriptorSetUniformBuffersDynamic
        dd 0 ;padding
        dd 0  ;maxDescriptorSetStorageBuffers
        dd 0 ;padding
        dd 0  ;maxDescriptorSetStorageBuffersDynamic
        dd 0 ;padding
        dd 0  ;maxDescriptorSetSampledImages
        dd 0 ;padding
        dd 0  ;maxDescriptorSetStorageImages
        dd 0 ;padding
        dd 0  ;maxDescriptorSetInputAttachments
        dd 0 ;padding
        dd 0  ;maxVertexInputAttributes
        dd 0 ;padding
        dd 0  ;maxVertexInputBindings
        dd 0 ;padding
        dd 0  ;maxVertexInputAttributeOffset
        dd 0 ;padding
        dd 0  ;maxVertexInputBindingStride
        dd 0 ;padding
        dd 0  ;maxVertexOutputComponents
        dd 0 ;padding
        dd 0  ;maxTessellationGenerationLevel
        dd 0 ;padding
        dd 0  ;maxTessellationPatchSize
        dd 0 ;padding
        dd 0  ;maxTessellationControlPerVertexInputComponents
        dd 0 ;padding
        dd 0  ;maxTessellationControlPerVertexOutputComponents
        dd 0 ;padding
        dd 0  ;maxTessellationControlPerPatchOutputComponents
        dd 0 ;padding
        dd 0  ;maxTessellationControlTotalOutputComponents
        dd 0 ;padding
        dd 0  ;maxTessellationEvaluationInputComponents
        dd 0 ;padding
        dd 0  ;maxTessellationEvaluationOutputComponents
        dd 0 ;padding
        dd 0  ;maxGeometryShaderInvocations
        dd 0 ;padding
        dd 0  ;maxGeometryInputComponents
        dd 0 ;padding
        dd 0  ;maxGeometryOutputComponents
        dd 0 ;padding
        dd 0  ;maxGeometryOutputVertices
        dd 0 ;padding
        dd 0  ;maxGeometryTotalOutputComponents
        dd 0 ;padding
        dd 0  ;maxFragmentInputComponents
        dd 0 ;padding
        dd 0  ;maxFragmentOutputAttachments
        dd 0 ;padding
        dd 0  ;maxFragmentDualSrcAttachments
        dd 0 ;padding
        dd 0  ;maxFragmentCombinedOutputResources
        dd 0 ;padding
        dd 0  ;maxComputeSharedMemorySize
        dd 0 ;padding
        times 3 dd 0 ;maxComputeWorkGroupCount[3]
        dd 0 ;padding
        dd 0  ;maxComputeWorkGroupInvocations
        dd 0 ;padding
        times 3 dd 0 ;maxComputeWorkGroupSize[3]
        dd 0 ;padding
        dd 0  ;subPixelPrecisionBits
        dd 0 ;padding
        dd 0  ;subTexelPrecisionBits
        dd 0 ;padding
        dd 0  ;mipmapPrecisionBits
        dd 0 ;padding
        dd 0  ;maxDrawIndexedIndexValue
        dd 0 ;padding
        dd 0  ;maxDrawIndirectCount
        dd 0 ;padding
        dd 0  ;padding if needed for alignment
        dd 0 ;padding
        dd 0  ;continue for floats and remaining fields...
        dd 0 ;padding

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
        call connectPhysicalDevice
        call no_error
        ret

    createInstance:
        sub rsp, 40
        lea rcx, [vk_struct_type_instance_info]
        xor rdx, rdx
        lea r8, [instance] 
        call vkCreateInstance
        add rsp, 40
       
        test rax, rax
        jnz error
        ret

    pickPhysicalDevice:
        sub rsp, 40
        mov rcx, [instance]
        lea rdx, [gpu_count]
        xor r8, r8
        call vkEnumeratePhysicalDevices
        add rsp, 40

        test rax, rax
        jnz error

        sub rsp, 40
        mov rcx, [instance]
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