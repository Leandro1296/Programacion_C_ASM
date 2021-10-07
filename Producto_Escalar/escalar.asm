;%include "io.inc"              ;descomentar para probar en nasm

global main
section .data

puntero dq 25.0,0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0
limite db 10
resultado dq 0.0
formato db "Posicion %d - El resultado de %f * %f es : %f", 10,13,0
n dq 23.0
r dq 0.0
numeroMul dq 0.0

section .text
extern printf
main:
    mov ebp, esp                ; for correct debugging
    
    ;Paso parametros
    push puntero                ;guardo el puntero
    mov edx, [n + 4]            ;paso el n
    push edx
    mov edx, [n]
    push edx
    
    call producto_rvf 
    add esp, 12

    ret
    
global producto_rvf
    
    producto_rvf:
        enter 0,0
        mov ebx, 0
        mov ecx, [limite]       ; limite 
        mov esi, 0              ;contador
        
        mov ebx, [ebp + 16]     ;guardo puntero  
        
        fld qword[ebp + 8]      ;n
        fst qword[r]   
        
        top: 
        fld qword[ebx + esi * 8]
        fst qword[numeroMul]
        fld qword[r]
        
        fmul 
        fst qword[resultado]
          
        ffree 
;Muestro el resultado
        push dword[resultado + 4]
        push dword[resultado] 
        
        push dword[r + 4]
        push dword[r]
        
        push dword[numeroMul + 4]        
        push dword[numeroMul]
        
        push esi
        
        push formato
        call printf
        add esp, 12
        
        inc esi
        cmp esi, [limite]
        jl top
    
        leave
        ret
    ret
