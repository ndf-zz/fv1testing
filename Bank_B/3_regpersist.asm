; FV-1 Testing
;
; Program: REG Persists
;
; Expected output if REG persists:
;       - first sample output should be MIN
;       - all following samples should grow toward MAX then saturate

equ	incval	0x000080	; increment
equ	minval	0x800000
equ	INC	REG0
equ	DEL	REG1

	skp	RUN,main
	clr
	or	incval		; save increment to reg
	wrax	INC,0.0
	or	minval		; set initial condition
	wrax	DEL,0.0

main:
	ldax	DEL		; load previous value
	wrax	DACL,1.0	; write out ACC
	rdax	INC,1.0		; increment
	wrax	DEL,0.0		; save ACC to reg
