section .bss 
    sum resd 1                  ; Переменная для хранения суммы 
 
section .text 
global _start 
 
_start: 
    pop ecx                     ; Количество аргументов 
    pop edx                     ; Имя программы 
    sub ecx, 1                  ; Уменьшаем на 1 (количество аргументов без имени программы) 
    mov dword [sum], 0         ; Инициализация суммы 
 
next_arg: 
    cmp ecx, 0                  ; Проверяем, есть ли еще аргументы 
    jz print_sum                ; Если нет, переходим к выводу суммы 
 
    pop eax                     ; Извлекаем аргумент 
    ; Преобразуем строку в число 
    ; Для этого добавим проверку на то, что аргумент не пустой и включает только цифры 
    cmp eax, 0                  ; Проверяем, не является ли аргумент 0 
    jz handle_invalid_argument   ; Если 0, обработка недопустимого аргумента 
 
    ; Преобразование строки в число 
    sub eax, '0'                ; Преобразуем ASCII символ в число 
    call f                      ; Вычисляем f(x) 
    add dword [sum], eax        ; sum += f(x) 
    loop next_arg               ; Переход к следующему аргументу 
 
print_sum: 
    mov eax, [sum]              ; Загружаем сумму в eax 
    call print_number            ; Печатаем сумму 
    call quit                   ; Завершение программы 
 
handle_invalid_argument: 
    ; Здесь можно добавить обработку недопустимого аргумента 
    jmp next_arg                ; Вернуться к следующему аргументу 
 
f: 
    ; Подпрограмма для вычисления f(x) 
    mov ebx, eax               ; Сохраняем x в ebx 
    imul eax, 6                ; eax = 6 * x 
    add eax, 3                 ; eax = eax + 3 (f(x) = 6x + 3) 
    ret                         ; Возвращаемся к вызванной функции 
 
print_number:                ; Процедура для печати числа (целое число в eax) 
    push eax                   ; Сохраняем число 
    mov ecx, 10               ; Делитель 
    xor edx, edx              ; Обнуляем остаток 
.next_digit: 
    test eax, eax              ; Проверяем, не стало ли число нулем 
    jz .print_loop             ; Если ноль, печатаем 
    div ecx                    ; Делим eax на 10 
    add dl, '0'                ; Превращаем остаток в символ 
    push dx                    ; Сохраняем символ в стеке 
    jmp .next_digit            ; Цикл для следующей цифры 
 
.print_loop: 
    mov ebx, 1                 ; stdout 
    mov edx, 1                 ; Один символ 
    pop eax                    ; Извлекаем символ 
    int 0x80                   ; Выводим на экран 
    cmp esp, ebp               ; Проверяем, закончились ли символы 
    jnz .print_loop            ; Если не закончились, продолжаем печать 
    ret 
 
quit: 
    mov eax, 1                 ; sys_exit 
    xor ebx, ebx               ; Код возврата 0 
    int 0x80
