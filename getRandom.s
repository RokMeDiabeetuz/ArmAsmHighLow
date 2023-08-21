@ generateNumber.s
@ generates a random number between the range of 50 to 100 and
@ returns it to the calling function.
@ csci 212, summer 2023
@ Daryll Guiang, 007419370
@ July 18 2023

@ define architecture
.cpu cortex-a72
.fpu neon-fp-armv8

@ text
.text
.align 2
.global createRandom
.type createRandom, %function

createRandom:
    push {fp, lr}       @ place lr onto the stack
    add fp, sp, #4      @ update stack pointer
    
    mov r0, #0          @ place 0 into r0
    bl time             @ call time function
    mov r3, r0          
    mov r0, r3
    bl srand            @ call srand function with time function result as arg
    bl rand             @ call rand to get random number
    mov r5, r0          @ move random number into r5
    mov r4, #100        @ add the max to r4
    sub r4, #50         @ remove the min from r4
    add r4, #1          @ add 1 to r4
    udiv r5, r5, r4     @ get modulos of the random number and results in r4
    mul r5, r5, r4      
    sub r0, r0, r5
    add r0, r0, #50     @ add the min to the modulus of random mod r4

    sub fp, sp, #4      @ update stack pointer
    pop {fp, pc}        @ return

