.text
.global main

.equ LED_CTL, 0x41210000

main:
    bl led0_on
    bl led0_off
    bl led0_toggle
    bl led0_toggle
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
.end
