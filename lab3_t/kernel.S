.syntax unified
.cpu cortex-m4
//.fpu softvfp
.thumb
//global memory locations

#define A #7
#define B #5
#define C #4

.global vtable_kernel
.global __kernel_reset__

.type vtable_kernel, %object
.type __kernel_reset__, %function

.section .interrupt_vector
vtable_kernel:
	.word __stack_start
	.word __kernel_reset__+1
	.size vtable_kernel, .-vtable_kernel

.section .rodata
	start: .asciz "kernel start\n"
	finish: .asciz "value in reg #1: "

.section .text
__kernel_reset__:
	ldr r0, =start
	bl dbgput_line
	//calculating

    push {lr}
mov r0, A
mov r1, B
mov r2, C
add r0, r1 // a+b
lsr r0, r0, #1 // (a+b)/2
mov r3, #1
   
fact:
    cmp r2, #1
    beq sum
    mul r3, r2
    sub r2, #1
    b fact

sum:
add r0, r3
pop {pc}
	mov r2, r0
	ldr r0, =finish
	bl dbgput
        mov r0, r2
        bl dbgput_num
        end:
		b end
