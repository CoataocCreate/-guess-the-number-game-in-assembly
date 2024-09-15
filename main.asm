.model small
.stack 100h
.data
    secret_number db 42        ; The number to guess
    prompt db 'Guess a number between 1 and 100: $'
    success_msg db 'Congratulations! You guessed correctly! $'
    failure_msg db 'Wrong guess. Try again. $'
    error_msg db 'Invalid input. Enter a number. $'
    input db ?
.code
main proc
    ; Initialize the data segment
    mov ax, @data
    mov ds, ax

    ; Display prompt
    mov ah, 09h
    lea dx, prompt
    int 21h

    ; Get input from user
    mov ah, 0Ah
    lea dx, input
    int 21h

    ; Convert input to number
    mov al, input+1
    sub al, '0'
    mov bl, al

    ; Compare with secret number
    mov al, secret_number
    cmp bl, al
    je correct_guess

    ; If wrong, display failure message
    mov ah, 09h
    lea dx, failure_msg
    int 21h
    jmp main

correct_guess:
    ; If correct, display success message
    mov ah, 09h
    lea dx, success_msg
    int 21h

    ; Exit program
    mov ah, 4Ch
    int 21h
main endp
end main
