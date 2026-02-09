.text
.global main

.equ LED_CTL, 0x41210000
.equ BTN_DATA, 0x41200000

main:
	ldr r1, =BTN_DATA
	ldr r2, =LED_CTL
loop:
	ldr r0, [r1]
	str r0, [r2]
	b loop
.end
