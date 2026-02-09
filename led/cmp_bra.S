.text
.global main

.equ LED_CTL, 0x41210000
.equ SW_DATA, 0x41220000

main:
	ldr r1, =SW_DATA
	ldr r2, =LED_CTL
loop:
	ldr r0, [r1]
	cmp r0, #20 
	beq first_led
	mov r3, #0xFFF 
	cmp r0, r3
	beq second_led
	b off
first_led:
	mov r0, #1
	str r0, [r2]
	b loop
second_led:
	mov r0, #2
	str r0, [r2]
	b loop
off:
	mov r0, #0
	str r0, [r2]
	b loop
.end
