.text
.global main

.equ LED_CTL, 0x41210000
.equ SW_DATA, 0x41220000

main:
	ldr r1, =SW_DATA
	ldr r2, =LED_CTL
loop:
	ldr r0, [r1]
	cmp r0, #3
	ble led_one
	cmp r0, #7
	ble led_two
	cmp r0, #11
	ble led_three
	cmp r0, #15
	ble led_four
	b led_off
led_one:
	mov r0, #1
	str r0, [r2]
	b loop
led_two:
	mov r0, #2
	str r0, [r2]
	b loop
led_three:
	mov r0, #4
	str r0, [r2]
	b loop
led_four:
	mov r0, #8
	str r0, [r2]
	b loop
led_off:
	mov r0, #0
	str r0, [r2]
	b loop
