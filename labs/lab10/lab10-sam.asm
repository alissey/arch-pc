;--------------------------------
; Программа для записи имени в файл
;--------------------------------
%include 'in_out.asm'

SECTION .data
filename db 'name.txt', 0h           ; Имя создаваемого файла
prompt db 'Как Вас зовут? ', 0h      ; Сообщение для ввода имени
intro db 'Меня зовут ', 0h           ; Сообщение для записи в файл

SECTION .bss
name resb 255                        ; Буфер для ввода имени

SECTION .text
global _start

_start:
    ; --- Вывод приглашения "Как Вас зовут?"
    mov eax, prompt                  ; Указатель на сообщение
    call sprint                      ; Печать сообщения

    ; --- Ввод строки с клавиатуры
    mov ecx, name                    ; Указатель на буфер
    mov edx, 255                     ; Максимальная длина строки
    call sread                       ; Чтение строки

    ; --- Создание файла name.txt (`sys_open`) с правами rwx для всех
    mov ecx, 0101o                   ; Флаги O_CREAT | O_WRONLY
    mov edx, 0777                     ; Права доступа rwx для всех
    mov ebx, filename                ; Указатель на имя файла
    mov eax, 5                        ; syscall open
    int 80h

    ; --- Сохранение дескриптора файла
    mov esi, eax                     ; Сохранить дескриптор в esi

    ; --- Запись строки "Меня зовут" в файл (`sys_write`)
    mov eax, intro                   ; Указатель на сообщение
    call slen                        ; Вычисление длины строки
    mov edx, eax                     ; Длина строки
    mov ecx, intro                   ; Указатель на сообщение
    mov ebx, esi                     ; Дескриптор файла
    mov eax, 4                       ; syscall write
    int 80h

    ; --- Добавление имени пользователя в файл
    mov eax, name                    ; Указатель на введённую строку
    call slen                        ; Вычисление длины строки
    mov edx, eax                     ; Длина строки
    mov ecx, name                    ; Указатель на имя
    mov ebx, esi                     ; Дескриптор файла
    mov eax, 4                       ; syscall write
    int 80h

    ; --- Закрытие файла (`sys_close`)
    mov ebx, esi                     ; Дескриптор файла
    mov eax, 6                       ; syscall close
    int 80h

    ; --- Завершение программы
    call quit
