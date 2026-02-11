.text
.global main

.equ LED_CTL, 0x41210000
.equ SW_DATA, 0x41220000

main:
	mov r0, #0x6000
	mov r1, #0x5000
	bl time_set
	b main

led0_on:
    ldr r1, =LED_CTL
    ldr r0, [r1]    @get current value
    orr r0, r0, #1    @set the first bit (don't affect other bits)
    str r0, [r1]    @write back to LED_DATA
    bx lr        @return from subroutine
led0_off:
    ldr r1, =LED_CTL
    ldr r0, [r1]
    bic r0, r0, #1
    str r0, [r1]
    bx lr
led0_toggle:
    ldr r1, =LED_CTL
    ldr r0, [r1]
    eor r0, r0, #1
    str r0, [r1]
    bx lr
time_set:
	push {r4, r5, r6, lr}
	mov r4, r0
	mov r5, r1
	subs r6, r4, r5
	bl led0_on
	delay_on:
		subs r5, r5, #1
		bne delay_on
	bl led0_off
	delay_off:
		subs r6, r6, #1
		bne delay_off
	pop {r4, r5, r6, lr}
	bx lr

.end

