;--------------------------------
; Программа вычисления выражения
;--------------------------------
%include 'in_out.asm' ; подключение внешнего файла
SECTION .data 
msg: DB 'Введите x: ', 0 
rem: DB 'Результат: ', 0 
 
SECTION .bss 
x: RESB 80  
result: RESD 1  
 
SECTION .text 
GLOBAL _start 
 
_start: 
    ; ---- Вычисление выражения 
    mov eax, msg 
    call sprintLF  ; Вывод сообщения 
 
    mov ecx, x 
    mov edx, 80 
    call sread     ; Чтение ввода пользователя 
 
    mov eax, x     ; Подготовка ввода для преобразования 
    call atoi      ; Преобразование строки в целое число 
 
    ; Вычисляем выражение y = 5(x + 18) - 28 
    add eax, 18    ; x + 18 
    mov ebx, 5     ; Умножаем на 5 
    imul eax, ebx  ; eax = 5 * (x + 18) 
     
    sub eax, 28    ; y = 5(x + 18) - 28 
    mov [result], eax ; Сохраняем результат 
 
    ; Выводим результат 
    mov eax, rem 
    call sprint     ; Вывод сообщения о результате 
 
    mov eax, [result]  ; Загружаем результат в eax 
    call iprintLF      ; Печатаем результат 
 
    call quit  ; Завершаем программу


