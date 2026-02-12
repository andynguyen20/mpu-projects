.text
.global main

.equ SVN_SEG_CTL, 0x43C10000
.equ SVN_SEG_DATA, 0x43C10004
.equ SW_DATA, 0x41220000
.equ BTN_DATA, 0x41200000

main:
	mov r9, #0
	mov r8, #0
	mov r10, #0
	mov r11, #0
	bl sseg_bcd
	b sseg_ones

sseg_bcd:
	push {r4, r5}
	ldr r4, =SVN_SEG_CTL
	mov r5, #1
	str r5, [r4]
	pop {r4, r5}
	bx lr
sseg_ones:
	push {r4, r5, r6, lr}
	ldr r5, =SVN_SEG_DATA
	mov r4, #0
	ones_check:
		cmp r4, #9
		beq sseg_ones_escape
		add r4, r4, #1
		mov r6, #0xF
		and r4, r4, r6
		bic r9, r9, #0xF
		orr r9, r4, r9
		str r9, [r5]
		bl software_delay
		b ones_check
	sseg_ones_escape:
		bic r9, r9, #0xF
		str r9, [r5]
		pop {r4, r5, r6, lr}
		b sseg_tens
sseg_tens:
	push {r4, r5, r6, r7, lr}
	ldr r5, =SVN_SEG_DATA
	tens_check:
		cmp r8, #9
		beq sseg_tens_escape
		add r8, r8, #1
		mov r6, r8
		lsl r6, r6, #8
		mov r7, #0xF00
		and r6, r6, r7
		bic r9, r9, #0xF00
		orr r9, r9, r6
		str r9, [r5]
		bl software_delay
		pop {r4, r5, r6, r7, lr}
		b sseg_ones
	sseg_tens_escape:
		pop {r4, r5, r6, r7, lr}
		mov r8, #0
		mov r6, r8
		lsl r6, r6, #8
		mov r7, #0xF00
		and r6, r6, r7
		bic r9, r9, #0xF00
		orr r9, r9, r6
		str r9, [r5]
		b sseg_hundreds
sseg_hundreds:
	push {r4, r5, r6, r7, lr}
	ldr r5, =SVN_SEG_DATA
	hundreds_check:
		cmp r10, #9
		beq sseg_hundreds_escape
		add r10, r10, #1
		mov r6, r10
		lsl r6, r6, #16
		mov r7, #0xF0000
		and r6, r6, r7
		bic r9, r9, #0xF0000
		orr r9, r9, r6
		str r9, [r5]
		bl software_delay
		pop {r4, r5, r6, r7, lr}
		b sseg_ones
	sseg_hundreds_escape:
		pop {r4, r5, r6, r7, lr}
		mov r10, #0
		mov r6, r10
		lsl r6, r6, #16
		mov r7, #0xF0000
		and r6, r6, r7
		bic r9, r9, #0xF0000
		orr r9, r9, r6
		str r9, [r5]
		b sseg_thousands
sseg_thousands:
	push {r4, r5, r6, r7, lr}
	ldr r5, =SVN_SEG_DATA
	thousands_check:
		cmp r11, #9
		beq sseg_thousands_escape
		add r11, r11, #1
		mov r6, r11
		lsl r6, r6, #24
		mov r7, #0xF000000
		and r6, r6, r7
		bic r9, r9, #0xF000000
		orr r9, r9, r6
		str r9, [r5]
		bl software_delay
		pop {r4, r5, r6, r7, lr}
		b sseg_ones
	sseg_thousands_escape:
		mov r8, #0
		mov r10, #0
		mov r11, #0
		mov r9, #0
		str r9, [r5]
		pop {r4, r5, r6, r7, lr}
		b sseg_ones
software_delay:
	push {r4, r5, lr}
	movw r4, #0
	movt r4, #0x0010
	delay:
		subs r4, r4, #1
		bne delay
	pop {r4, r5, lr}
	bx lr
.end
