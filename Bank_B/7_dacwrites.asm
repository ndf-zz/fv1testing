; FV-1 Testing
;
; Program: DAC Mult Write
;
; Expected output:
;	- MAXVAL or MINVAL

equ	minval	0x800000
equ	maxval	0x7fffff

	clr
	or	minval
	wrax	DACL,0.0

; pad to halfway
	nop	nop	nop	nop	nop
	nop	nop	nop	nop	nop	nop	nop	nop
	nop	nop	nop	nop	nop	nop	nop	nop
	nop	nop	nop	nop	nop	nop	nop	nop
	nop	nop	nop	nop	nop	nop	nop	nop
	nop	nop	nop	nop	nop	nop	nop	nop
	nop	nop	nop	nop	nop	nop	nop	nop
	nop	nop	nop	nop	nop	nop	nop	nop

; write out the maxval
	clr
	or	maxval
	wrax	DACL,0.0
