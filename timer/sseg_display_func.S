.text
.global main

.equ SVN_SEG_CTL, 0x43C10000
.equ SVN_SEG_DATA, 0x43C10004
.equ SW_DATA, 0x41220000
.equ BTN_DATA, 0x41200000

main:
	bl return_btn
	mov r1, r0 // <- Digit to be displayed
	mov r2, #4 // <- Value to be displayed
	bl display_sseg
	b main
display_sseg:
	cmp r1, #1
	blt display_return
	cmp r1, #4
	bgt display_return
	push {r4, r5, r6, r7, r8, lr}
	mov r4, r1 // digit to be turned on
	subs r4, r4, #1
	mov r5, r2 //data to be displayed
	ldr r6, =SVN_SEG_CTL
	mov r7, #1
	str r7, [r6] // turn on sseg display and use BCD mode
	ldr r8, =SVN_SEG_DATA
	display_loop:
		cmp r4, #0
		beq display_continue
		lsl r5, r5, #8
		subs r4, r4, #1
		b display_loop
	display_continue:
	str r5, [r8]
	pop {r4, r5, r6, r7, r8, lr}
	display_return:
		bx lr
return_sw:
	push {r4, r5}
	ldr r4, =SW_DATA
	ldr r0, [r4]
	pop {r4, r5}
	bx lr
return_btn:
	push {r4, r5}
	ldr r4, =BTN_DATA
	ldr r0, [r4]
	pop {r4, r5}
	bx lr
end:
	b end
.end
