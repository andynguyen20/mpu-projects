.text
.global main

.equ LED_CTL, 0x41210000

main:
    bl led0_on
    bl time_set
    bl led0_off
    bl time_set
    bl led0_toggle
    bl time_set
    bl led0_toggle
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
	movw r0, #0
	movt r0, #0x3000
	delay:
		subs r0, r0, #1
		bne delay
	bx lr
.end
