@ main.s
@ generate random number, get user input and plays a game of high or low.
@ csci 212, summer 2023
@ Daryll Guiang, 007419370
@ July18 2023

@ define architecture
.cpu cortex-a72
.fpu neon-fp-armv8

@ define variables
.data
tooLow:     .asciz  "\nSorry, you guessed too LOW.\n"
tooHigh:    .asciz  "\nSorry, you guessed too HIGH.\n"
correct:    .asciz  "Correct! You guessed %d with a total of %d tries\n"
wrong:      .asciz  "Sorry, you couldn't guess in 7 tries. The number is %d\n"
numStore:   .asciz  "%d "
number:     .word   0

@ text
.text
.align 2
.global main
.type main, %function

@ main function
main:
    push {fp, lr}          @ store lr in stack
    add fp, sp, #4
    bl createRandom         @ get random num, store in r10
    mov r4, r0
    mov r5, #0              @ set counter to 1
    loop:                   @ start loop
        add r5, r5, #1      @ increment by 1
        cmp r5, #8          @ check if counter is 8, end if so
        beq loseEnd
        push {r4, r5}       @ push r4/r5 values to stack to save values
        bl getGuess         @ get user guess, store in r8
        pop {r4, r5}        @ pop from stack to return r4/r5 values
        mov r7, r0    
        cmp r7, r4          @ compare user input to number
        blt low             @ to go low if too low
        cmp r7, r4          
        bgt high            @ go to high if too high
        cmp r7, r4          
        beq winEnd          @ if equal, go to winning end
        bl loop

@ too low
low:
    ldr r0, =tooLow
    bl printf
    bl loop

@ too high
high:
    ldr r0, =tooHigh
    bl printf
    bl loop

@ correct end
winEnd:
    ldr r0, =correct
    mov r1, r4
    mov r2, r5
    bl printf
    sub fp, sp, #4
    pop {fp, pc}

@ bad end
loseEnd:
    ldr r0, =wrong
    mov r1, r4
    bl printf
    sub fp, sp, #4
    pop {fp, pc}
