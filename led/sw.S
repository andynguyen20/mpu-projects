.text
.global main

.equ LED_CTL, 0x41210000
.equ SW_DATA, 0x41220000

main:
	ldr r1, =SW_DATA // load switch address from constant
	ldr r2, =LED_CTL // load led address from constant
loop:
	ldr r0, [r1] // load r0 with dereferenced value of r1
	str r0, [r2] // store r0 into dereferenced location of r2
	b loop // branch back to loop
.end
