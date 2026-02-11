.text
.global main

.equ LED_CTL, 0x41210000
.equ SW_DATA, 0x41220000

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
	ldr r2, =SW_DATA
	ldr r0, [r2]
	mov r3, #16
	mul r0, r0, r3
	lsl r0, r0, #19 
	cmp r0, #0
    beq done_delay
	delay:
		subs r0, r0, #1
		bne delay
	done_delay:
		bx lr
.end

