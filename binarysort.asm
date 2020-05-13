
section .data
    ; define array 
    list dw 9, 4, 1, 4, 3, 2, 2, 4, 7
    ; defing array length
    list_len dd 9
    ; define 
    nl db 0xA
    nlLen equ $-nl


section .bss
    count resb 1


section .text
    global _start

_start: 

    call print_arr
   
    call sort
    call print_arr
    mov eax, 1
    int 80h
  

sort:
    mov eax, 1
    
L2: 
    push eax
    mov ebx, eax 

    
L1:
    
    push ebx
    shl ebx, 1
    mov eax, list
    add eax, ebx
    
   
    ; Do comparison and swap
    mov cl, [eax]   ; get indexed number
    sub eax, 2
    mov bl, [eax]   ; get previous index
    cmp cl, bl
    jle skip_swap
    mov [eax], cl
    add eax, 2
    mov [eax], bl
skip_swap:

    ; Uncomment to print parsing pattern
    ; mov ecx, [eax]
    ; or ecx, '0'
    ; mov [count], ecx
    ; call print_val
    
    pop ebx 
    inc ebx
    cmp ebx, [list_len]
  
    jnz L1 
   
    pop eax
    inc eax
    cmp eax, [list_len]
    jnz L2

    ret

; Print array Procedure
print_arr:

    mov ebx, 0 
L3:
    
    push ebx
    shl ebx, 1
    mov eax, list
    add eax, ebx

    mov ecx, [eax]   ; get previous index

    or ecx, '0'
    mov [count], ecx
    
    call print_val
    
    pop ebx 
    inc ebx
    cmp ebx, [list_len]
  
    jnz L3

    call print_nl
    call print_nl
    ret 
       
; Print single value
print_val:
    mov eax, 4           
    mov ebx, 1     
    mov ecx, count
    mov edx, 1
    int 80h
    ret

; Print new line
print_nl:
    mov eax, 4           
    mov ebx, 1     
    mov ecx, nl
    mov edx, nlLen
    int 80h

    ret
      
   
