@ getUserGuess.s
@ prompts user for input, returns if valid, otherwise loops and retry.
@ csci 212, summer 2023
@ Daryll Guiang, 007419370
@ July 18 2023

@ define architecture
.cpu cortex-a72
.fpu neon-fp-armv8

@ define variables
.data
prompt1:    .asciz  "\n\tEnter a number between 50 and 100: \n"
error1:     .asciz  "\n\tSorry, you entered a number less than 50, try again: \n"
error2:     .asciz  "\n\tSorry, you entered a number more than 100, try again: \n"
numStore:   .asciz  "%d"
number:     .word   0

@ text
.text
.align 2
.global getGuess
.type getGuess, %function

@ get guess method
getGuess:
    push {fp, lr}           @ store lr into stack, update stack
    add fp, sp, #4
    loop:                   @ prompt user for input, loop until valid value
        ldr r0, =prompt1    @ print prompt
        bl printf
        ldr r0, =numStore   @ load format specifier
        ldr r1, =number     @ load variable address 
        bl scanf            @ scan user input
        ldr r4, =number     @ load value entered into r6
        ldr r4, [r4]
        cmp r4, #100        @ compare to max, notify error if so
        bgt tooLarge
        cmp r4, #50         @ compare to min, notify error if so
        blt tooSmall
        mov r0, r4
        bl end

tooLarge: @ error message and restart if number entered too large.
    ldr r0, =error2
    bl printf
    bl loop

tooSmall:  @ error message and restart if number entered too large.
    ldr r0, =error1
    bl printf
    bl loop

end:    @ end and return value selected.
    sub fp, sp, #4
    pop {fp, pc}


