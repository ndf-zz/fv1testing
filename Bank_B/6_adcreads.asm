; FV-1 Testing
;
; Program: ADC Mult Read
;
; Expected output:
;	- MAXVAL if ADC is the same
;	- MINVAL if ADC changes

equ	minval	0x800000
equ	maxval	0x7fffff
equ	epsilon	0xffffff
equ	MIN	REG0
equ	MAX	REG1
equ	JUNK	REG2

	skp	RUN,main
	clr
	or	minval		; prepare pass/fail flags
	wrax	MIN,0.0
	or	maxval
	wrax	MAX,0.0

main:	ldax	ADCL		; load ADC

; pad to end of prog
	nop	nop	nop	nop	nop	nop	nop	nop
	nop	nop	nop	nop	nop	nop	nop	nop
	nop	nop	nop	nop	nop	nop	nop	nop
	nop	nop	nop	nop	nop	nop	nop	nop
	nop	nop	nop	nop	nop	nop	nop	nop
	nop	nop	nop	nop	nop	nop	nop	nop
	nop	nop	nop	nop	nop	nop	nop	nop
	nop	nop	nop	nop	nop	nop	nop	nop
	nop	nop	nop	nop	nop	nop	nop	nop
	nop	nop	nop	nop	nop	nop	nop	nop
	nop	nop	nop	nop	nop	nop	nop	nop
	nop	nop	nop	nop	nop	nop	nop	nop
	nop	nop	nop	nop	nop	nop	nop	nop
	nop	nop	nop	nop	nop	nop	nop	nop
	nop

; compare ADC to previous value
	ldax	ADCL		; load ADC again
	wrhx	JUNK,-1.0	; subtract PACC from ACC
	;and	epsilon		; apply epsilon if reqd
	skp	ZRO,pass
fail:	ldax	MIN
	wrax	DACL,0.0
	skp	ZRO,end
pass:	ldax	MAX
	wrax	DACL,0.0
end:
