.text
.global main

.equ SVN_SEG_CTL, 0x43C10000
.equ SVN_SEG_DATA, 0x43C10004
.equ SW_DATA, 0x41220000
.equ BTN_DATA, 0x41200000

main:
	bl bcd_sseg
	loop:
		bl display_sseg
		b loop
bcd_sseg:
	push {r4, r5, lr}
	ldr r4, =SVN_SEG_CTL
	mov r5, #1
	str r5, [r4]
	pop {r4, r5, lr}
	bx lr
display_sseg:
	push {r4, r5, r6, r7, r8, lr}
	ldr r4, =SW_DATA
	ldr r5, [r4]
	mov r8, #0
	mov r6, #15
	and r7, r5, r6
	orr r8, r8, r7 //sseg1
	mov r6, #240
	and r7, r5, r6
	lsl r7, r7, #4
	orr r8, r8, r7 //sseg2
	mov r6, #3840
	and r7, r5, r6
	lsl r7, r7, #8
	orr r8, r8, r7//sseg3
	ldr r4, =BTN_DATA
	ldr r5, [r4]
	mov r6, #15
	and r7, r5, r6
	lsl r7, r7, #24
	orr r8, r8, r7
	ldr r9, =SVN_SEG_DATA
	str r8, [r9]
	pop {r4, r5, r6, r7, r8, lr}
	bx lr
end:
	b end
.end
