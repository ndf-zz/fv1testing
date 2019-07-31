; FV-1 Testing
;
; Program: ACC Delay Elem
;
; Expected output:
;       - first sample output should be MIN
;       - all following samples should grow toward MAX then saturate


equ	incval	0x000001	; increment
equ	minval	0x800000
equ	INC	REG0

	skp	RUN,main
	clr
	or	incval		; save increment to reg
	wrax	INC,0.0
	or	minval		; set initial condition

main:
	wrax	DACL,1.0	; write out ACC
	rdax	INC,1.0		; increment
