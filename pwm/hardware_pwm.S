.text
.global main

.equ RGB_EN, 0x43C00000
.equ RGB_PERIOD, 0x43C00004
.equ RGB_WIDTH, 0x43C00008

main:
	mov r0, #5 // <- r0 chooses which RGB channel to use (change value of r0 for different channel)
	bl pwm_channel_enable
	mov r0, #5
	mov r1, #0x5000 // r1 chooses width and duty cycle of pulse width (change value with respect to width and duty cycle)
	bl pwm_window_width
	mov r0, #5
	mov r1, #0x6000
	bl pwm_duty_value
	b end
pwm_channel_enable:
	cmp r0, #5
	bgt enable_return
	push {r4, r5, r6, r7}
	mov r4, r0
	mov r5, #0x10
	mul r4, r4, r5
	ldr r6, =RGB_EN
	add r6, r6, r4
	mov r7, #1
	str r7, [r6]
	pop {r4, r5, r6, r7}
	enable_return:
		bx lr
pwm_channel_disable:
	cmp r0, #5
	bgt disable_return
	push {r4, r5, r6, r7}
	mov r4, r0
	mov r5, #0x10
	mul r4, r4, r5
	ldr r6, =RGB_EN
	add r6, r6, r4
	mov r7, #0
	str r7, [r6]
	pop {r4, r5, r6, r7}
	disable_return:
		bx lr
pwm_window_width:
	cmp r0, #5
	bgt width_return
	push {r4, r5, r6, r7}
	mov r4, r0 // save channel
	mov r5, r1 // save width
	mov r6, #0x10
	mul r4, r4, r6
	ldr r7, =RGB_WIDTH
	add r7, r7, r4
	str r5, [r7]
	pop {r4, r5, r6, r7}
	width_return:
		bx lr
pwm_duty_value:
	cmp r0, #5
	bgt duty_return
	push {r4, r5, r6, r7}
	mov r4, r0 // save channel
	mov r5, r1 // save period
	mov r6, #0x10
	mul r4, r4, r6
	ldr r7, =RGB_PERIOD
	add r7, r7, r4
	str r5, [r7]
	pop {r4, r5, r6, r7}
	duty_return:
		bx lr
end:
	b end
.end




