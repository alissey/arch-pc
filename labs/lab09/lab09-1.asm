%include 'in_out.asm' 
SECTION .data
msg: DB 'Введите x: ', 0
result: DB 'f(g(x)) = ', 0
SECTION .bss
x: RESB 80
res: RESB 80
SECTION .text
GLOBAL _start
_start:    
;------------------------------------------
    ; Основная программа    
    ;------------------------------------------
    mov eax, msg   
    call sprint               ; Вывести сообщение пользователю
    mov ecx, x               ; Поместить адрес x в ecx   
    mov edx, 80              ; Максимальная длина ввода
    call sread               ; Прочитать x с клавиатуры    
    mov eax, [x]             ; Преобразовать строку в число
    call atoi                ; Преобразовать строку в число    
    call _calcul             ; Вызов подпрограммы _calcul
    mov eax, result    
    call sprint              ; Вывести результат
    mov eax, [res]          ; Переместить результат в eax    
    call iprintLF            ; Вывести результат
    call quit                ; Завершить программу
;------------------------------------------
; Подпрограмма вычисления
; выражения "2x + 7" с использованием g(x)
_calcul:
push eax
call _subcalcul
mov ebx, eax             ; Переместить x в ebx
pop eax
mov eax, ebx
    mov ebx, 2               ; Установить множитель 2
    mul ebx                  ; Умножить g(x) на 2    
    add eax, 7               ; Добавить 7
    mov [res], eax           ; Сохранить результат     
    ret
; Подпрограмма вычисления g(x) = 3x - 1
_subcalcul:    
	mov ebx, 3               ; Установить множитель 3
    	mul ebx                  ; Умножить x на 3    
    	sub eax, 1               ; Вычесть 1
    	ret                      ; Возврат результата в eax
