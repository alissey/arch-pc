%include 'in_out.asm' 
SECTION .data 
div: DB 'Результат: ',0 
SECTION .text 
GLOBAL _start 
_start: 
; ---- Вычисление выражения (3 + 2) * 4 + 5 
mov ebx, 3      ; ebx = 3 
add ebx, 2      ; ebx = ebx + 2 -> ebx = 5 
mov eax, ebx    ; eax = 5 
mov ecx, 4      ; ecx = 4 
mul ecx         ; eax = eax * ecx -> eax = 5 * 4 = 20 
add eax, 5      ; eax = eax + 5 -> eax = 20 + 5 = 25 
mov edi, eax    ; ---- Вывод результата на экран 
mov eax, div 
call sprint 
mov eax, edi 
call iprintLF 
call quit
