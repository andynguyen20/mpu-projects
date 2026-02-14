.text
.global main

.equ SVN_SEG_CTL, 0x43C10000
.equ SVN_SEG_DATA, 0x43C10004
.equ SW_DATA, 0x41220000
.equ BTN_DATA, 0x41200000

main:
	bl sseg_bcd
	mov r12, #0 //entire timer variable (global)
	main_loop:
		push {r4, r5}
		ldr r4, =BTN_DATA
		ldr r5, [r4]
		cmp r5, #1
		pop {r4, r5}
		bleq reset
		b sseg_ones

reset:
	push {r4, r5}
	mov r12, #0
	ldr r4, =SVN_SEG_DATA
	str r12, [r4]
	pop {r4, r5}
	bx lr

sseg_ones:
	push {r4, r5}
	ldr r4, =SVN_SEG_DATA
	and r5, r12, #0xF // extract bcd ones portion of r12
	cmp r5, #10 // extra 1 allows 9 to get full time displayed
	beq sseg_ones_pop
	str r12, [r4] // display data
	bl software_delay
	add r5, r5, #1
	bic r12, r12, #0xF // clear BCD_ones before orring back added amount
	orr r12, r12, r5 // (Note that 10 is stored back into r12. beq condition will check, sseg_tens needs to increment the tens bit and clear the 10 in ones to 0)
	pop {r4, r5}
	b main_loop
	sseg_ones_pop:
		pop {r4, r5}
		b sseg_tens
sseg_tens:
	push {r4, r5, r6}
	ldr r4, =SVN_SEG_DATA
	and r5, r12, #0xF00 // extract bcd tens portion of r12
	lsr r5, r5, #8
	cmp r5, #9
	beq sseg_tens_pop
	add r5, r5, #1
	lsl r5, r5, #8
	bic r12, #0xF //ones bit clear
	bic r12, #0xF00 //tens bit clear
	orr r12, r12, r5
	str r12, [r4]
	pop {r4, r5, r6}
	b main_loop
	sseg_tens_pop:
		pop {r4, r5, r6}
		b sseg_hundreds
sseg_hundreds:
	push {r4, r5, r6}
	ldr r4, =SVN_SEG_DATA
	and r5, r12, #0xF0000
	lsr r5, r5, #16
	cmp r5, #9
	beq sseg_hundreds_pop
	add r5, r5, #1
	lsl r5, r5, #16
	bic r12, r12, #0xF //clear ones
	bic r12, r12, #0xF00 //clear tens
	bic r12, r12, #0xF0000 //clear hundreds
	orr r12, r12, r5
	str r12, [r4]
	pop {r4, r5, r6}
	b main_loop
	sseg_hundreds_pop:
		pop {r4, r5, r6}
		b sseg_thousands
sseg_thousands:
	push {r4, r5, r6}
	ldr r4, =SVN_SEG_DATA
	and r5, r12, #0xF000000
	lsr r5, r5, #24
	cmp r5, #9
	beq sseg_thousands_pop
	add r5, r5, #1
	lsl r5, r5, #24
	bic r12, r12, #0xF
	bic r12, r12, #0xF00
	bic r12, r12, #0xF0000
	bic r12, r12, #0xF000000
	orr r12, r12, r5
	str r12, [r4]
	pop {r4, r5, r6}
	b main_loop
		sseg_thousands_pop:
			mov r12, #0
			str r12, [r4]
			pop {r4, r5, r6}
			b main_loop
software_delay:
	push {r4, r5, lr}
	movw r4, #0
	movt r4, #0x0090
	delay:
		subs r4, r4, #1
		bne delay
	pop {r4, r5, lr}
	bx lr
sseg_bcd:
	push {r4, r5}
	ldr r4, =SVN_SEG_CTL
	mov r5, #1
	str r5, [r4]
	pop {r4, r5}
	bx lr
.end
