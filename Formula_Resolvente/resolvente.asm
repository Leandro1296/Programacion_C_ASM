;%include "io.inc"  se comenta para ejecutar desde C

section .data
 
 format db "x1 = %f, x2 = %f", 10,0
 
 ;Inputs
 valueA dq 0.0
 valueB dq 0.0
 valueC dq 0.0
 
 ;Constants
 constantFour dq 4.0
 constantTwo dq 2.0
 
 ;Temp Results
 tempRoot dq 0.0
 tempDiv dq 0.0
 tempNeg dq 0.0
 
 ;Results
 x1 dq 0.0
 x2 dq 0.0

section .text
    extern printf
    global CMAIN
CMAIN:
    ;mov ebp, esp; for correct debugging sirve para debug con esto se produce un  
    enter 0,0      ;stack smashing detected

    ;valor a
    fld dword[ebp + 8]
    fst qword[valueA]
    ffree
    
    ;valor b
    fld dword[ebp + 12] ;se levanta como dword antes se intento como qword
    fst qword[valueB]
    ffree
    
    ;valor c
    fld dword[ebp + 16]
    fst qword[valueC]
    ffree
   
 ; -b
    fld qword[valueB]
    fchs
    fst qword[tempNeg]
    ffree
   
 ;sqrt(b² - 4.a.c)
    
    fld qword[valueB]
    fld qword[valueB]
    fmul              ;b²
    ffree
    
    fld qword[constantFour]
    fld qword[valueA]
    fmul
    fld qword[valueC]
    fmul             ;4.a.c
    
    fsub             ;b²-4.a.c
    fsqrt            
    fst qword[tempRoot]
    ffree
    
 ;2.a
    fld qword[constantTwo]
    fld qword[valueA]
    fmul
    fst qword[tempDiv]
    ffree
    
 ;x1:
    fld qword[tempNeg]
    fld qword[tempRoot]   
    fadd
    fld qword[tempDiv]
    fdiv
    fst qword[x1]
    ffree
    ffree
    ffree 
 ;x2:
    fld qword[tempNeg]
    fld qword[tempRoot]   
    fsub
    fld qword[tempDiv]
    fdiv
    fst qword[x2]
    ffree
    ffree
    ffree
    
;Mostrar
      push dword[x2 + 4];4
      push dword[x2];4
      push dword[x1 + 4];4
      push dword[x1];4
   
      push format ;4 
    
      call printf
      add esp, 20
    
      leave
   ret
    
    
 
